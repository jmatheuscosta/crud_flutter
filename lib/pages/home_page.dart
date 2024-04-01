import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/read%20data/get_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color azulPadrao =       const Color.fromRGBO(1, 15, 39, 1); // 1 para opacidade total
Color verdePadrao =      const Color.fromRGBO(77, 167, 104, 1); // 1 para opacidade total
Color backgroundPadrao = const  Color.fromRGBO(175, 175, 175, 1);

class HomePage extends StatefulWidget{
  const HomePage({ super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];

  @override
  void initState() {
    super.initState();
    getDocId(); // Chame a função getDocId() aqui
  }

  Future<void> getDocId() async {
    await FirebaseFirestore.instance.collection('usuarios').orderBy('nome', descending: false).get().then(
      (snapshot) => snapshot.docs.forEach((documento) {
        docIDs.add(documento.reference.id);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPadrao,
      appBar: AppBar(
        backgroundColor: azulPadrao,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              user.email!,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: Colors.white,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'CRUD',
              style: GoogleFonts.robotoSlab(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 2.0,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Icon(Icons.logout, color: Colors.white)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: GetUser(
                            documentId: docIDs[index],
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
