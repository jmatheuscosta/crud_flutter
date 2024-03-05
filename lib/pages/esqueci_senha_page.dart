import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color azulPadrao =       const Color.fromRGBO(1, 15, 39, 1); // 1 para opacidade total
Color verdePadrao =      const Color.fromRGBO(77, 167, 104, 1); // 1 para opacidade total
Color backgroundPadrao = const  Color.fromRGBO(175, 175, 175, 1);

class EsqueciSenhaPage extends StatefulWidget {
  const EsqueciSenhaPage({super.key});

  @override
  State<EsqueciSenhaPage> createState() => _EsqueciSenhaPageState();
}

class _EsqueciSenhaPageState extends State<EsqueciSenhaPage> {

  final _emailController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future resetarSenha() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text('Link para reset de senha enviado com sucesso!'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPadrao,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Digite seu email e mandaremos e mandaremos um link para resetar sua senha!',
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoSlab(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: azulPadrao,
                          letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 15.0),
          //email
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
            decoration: BoxDecoration( 
               border: Border.all(color: azulPadrao), // Define a cor da borda ao redor do Container
            ),
            child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal:16.0), // Preenchimento interno do TextField
              hintText: 'Digite seu email',
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          MaterialButton(
            onPressed: resetarSenha,
            child: 
            Text(
              'Resetar Senha',
              style: GoogleFonts.robotoSlab(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
            color: azulPadrao,
          )
        ],
      ),
    );
  }
}