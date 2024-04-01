// ignore_for_file: prefer_const_constructors
import 'package:crud/pages/esqueci_senha_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color azulPadrao =       const Color.fromRGBO(1, 15, 39, 1); // 1 para opacidade total
Color verdePadrao =      const Color.fromRGBO(77, 167, 104, 1); // 1 para opacidade total
Color backgroundPadrao = const  Color.fromRGBO(175, 175, 175, 1);

bool _showPassword = false;

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //text controllers
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(), 
      password: _senhaController.text.trim(),
      );
  }

  @override
  void dispose(){
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPadrao,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ //espaçamento
                Icon(
                  Icons.account_box_outlined,
                  size: 75,
                  color: azulPadrao,
                ),  
                //LOGIN
                Text(
                  'Bem Vindo',
                  style: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.w900,
                    fontSize: 45,
                    color: azulPadrao,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 30,), //espaçamento
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
                        fillColor: Color.fromRGBO(190, 190, 190, 1),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                //SENHA
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(        
                      border: Border.all(color: azulPadrao), // Define a cor da borda ao redor do Container       
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextField(
                          controller: _senhaController,
                          obscureText: !_showPassword, // Mostra ou oculta o texto com base no valor de _showPassword
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Preenchimento interno do TextField
                            hintText: 'Digite sua senha',
                            fillColor: Color.fromRGBO(190, 190, 190, 1),
                            filled: true, // Texto de dica dentro do TextField
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Alterna o valor de _showPassword
                            setState(() {_showPassword = !_showPassword; });
                          },
                          // Ícone para mostrar ou ocultar a senha
                          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off), 
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return EsqueciSenhaPage();
                          }));
                        },
                        child: Text(
                          'Esqueci a senha',
                          style: GoogleFonts.robotoSlab(
                            fontWeight: FontWeight.w900,
                            fontSize: 10.0,
                            color: azulPadrao,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                //BOTAO DE LOGIN
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 125.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: azulPadrao,
                        borderRadius: BorderRadius.circular(20.0),
                        ),
                      child: Center(
                        child: Text(
                          'ENTRAR',
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white, 
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            letterSpacing: 2.0,
                            ),
                        ),
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 5.0,), //espacamento 
                Center(            
                  child: 
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      'cadastre-se',
                      style:GoogleFonts.robotoSlab(
                              color: azulPadrao, 
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
