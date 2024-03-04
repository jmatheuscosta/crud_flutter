import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color azulPadrao =       const Color.fromRGBO(1, 15, 39, 1); // 1 para opacidade total
Color verdePadrao =      const Color.fromRGBO(77, 167, 104, 1); // 1 para opacidade total
Color backgroundPadrao = const  Color.fromRGBO(175, 175, 175, 1);

class HomePage extends StatefulWidget{
  const HomePage({ Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  final user  = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: backgroundPadrao,
      body: SafeArea(
        child: Center( //centraliza horizontalmente tudo que estiver dentro
          child: SingleChildScrollView( //centraliza verticalmente tudo que estiver dentro
            child: Column(
              children: [
                Text('logado como '+ user.email!),
                MaterialButton(
                  onPressed: (){
                    FirebaseAuth.instance.signOut();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: azulPadrao,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        'SAIR',
                        style: GoogleFonts.robotoSlab(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}