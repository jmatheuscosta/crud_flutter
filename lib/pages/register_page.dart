import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Adicione esta linha para importar o pacote intl
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Color azulPadrao = const Color.fromRGBO(1, 15, 39, 1); // 1 para opacidade total
Color verdePadrao = const Color.fromRGBO(77, 167, 104, 1); // 1 para opacidade total
Color backgroundPadrao = const Color.fromRGBO(175, 175, 175, 1);

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, Key? Key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

bool _showPassword = false;
String? _selectedRole;

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmasenhaController = TextEditingController();
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _telefoneController = TextEditingController();
  

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _confirmasenhaController.dispose();
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _dataNascimentoController.dispose();
    _telefoneController.dispose();  
    super.dispose();
  }

  Future signUp() async {
    if (senhaConfirmada()) {
      //cria usuario
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _senhaController.text.trim(),
      );
      
      //adiciona dados do usuario
      addDadosUsuario(
        _nomeController.text.trim(), 
        _sobrenomeController.text.trim(),  
        _dataNascimentoController.text.trim(), 
        _telefoneController.text.trim(),  
        _emailController.text.trim(), 
        );
    }
    // Aqui você pode usar o valor selecionado de _selectedRole conforme necessário
    print('Papel selecionado: $_selectedRole');
  }

  Future addDadosUsuario(String nome, String sobrenome, String dataNascimento, String telefone, String email) async {
    await FirebaseFirestore.instance.collection('usuarios').add({
      'nome': nome,
      'sobrenome': sobrenome,
      'data nascimento': dataNascimento,
      'telefone': telefone,
      'email': email,
    });
  }

  bool senhaConfirmada() => _senhaController.text.trim() == _confirmasenhaController.text.trim();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPadrao,
      appBar: AppBar(
        backgroundColor: azulPadrao,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.app_registration_outlined,
                  size: 75,
                  color: azulPadrao,
                ),
                //Cadastro
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
                  child: Container(
                    child: Text(
                      'Cadastro',
                      style: GoogleFonts.robotoSlab(
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0,
                        color: azulPadrao,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  //espaçamento
                  height: 30,
                ),

                //primeiro nome
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: azulPadrao),
                    ),
                    child: TextField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Nome',
                        fillColor: Color.fromRGBO(190, 190, 190, 1),
                        filled: true,
                      ),
                    ),       
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Segundo Nome
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: azulPadrao),
                    ),
                    child: TextField(
                      controller: _sobrenomeController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Sobrenome',
                        fillColor: Color.fromRGBO(190, 190, 190, 1),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: azulPadrao),
                    ),
                    child: TextField(
                      controller: _dataNascimentoController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _dataNascimentoController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Data de Nascimento',
                        fillColor: Color.fromRGBO(190, 190, 190, 1),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //telefone
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: azulPadrao),
                    ),
                    child: TextField(
                      controller: _telefoneController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Telefone',
                        fillColor: Color.fromRGBO(190, 190, 190, 1),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                 //email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: azulPadrao),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Email',
                        fillColor: Color.fromRGBO(190, 190, 190, 1),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //SENHA
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: azulPadrao),
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextField(
                          controller: _senhaController,
                          obscureText: !_showPassword,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            hintText: 'Senha',
                            fillColor: Color.fromRGBO(190, 190, 190, 1),
                            filled: true,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //CONFIRMAÇÃO DE SENHA
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: azulPadrao),
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextField(
                          controller: _confirmasenhaController,
                          obscureText: !_showPassword ? true : false,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            hintText: 'Confirme a senha',
                            fillColor: Color.fromRGBO(190, 190, 190, 1),
                            filled: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //BOTAO DE CADASTRO
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 125.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: azulPadrao,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Text(
                          'Cadastrar',
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
                Center(
                  child: GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      'entrar',
                      style: GoogleFonts.robotoSlab(
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
