import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color azulPadrao = const Color.fromRGBO(1, 15, 39, 1); // 1 para opacidade total
Color verdePadrao = const Color.fromRGBO(77, 167, 104, 1); // 1 para opacidade total
Color backgroundPadrao = const Color.fromRGBO(175, 175, 175, 1);

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

bool _showPassword = false;
String? _selectedRole;

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final _cpfController = TextEditingController();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmasenhaController = TextEditingController();

  @override
  void dispose() {
    _cpfController.dispose();
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmasenhaController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (senhaConfirmada()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _senhaController.text.trim(),
      );
    }
    // Aqui você pode usar o valor selecionado de _selectedRole conforme necessário
    print('Papel selecionado: $_selectedRole');
  }

  bool senhaConfirmada() => _senhaController.text.trim() == _confirmasenhaController.text.trim();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPadrao,
      appBar: AppBar(
        backgroundColor: azulPadrao,
        title: Center(
          child: Text(
            'IFaltou?',
            style: GoogleFonts.robotoSlab(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: widget.showLoginPage,
            icon: Icon(
              Icons.login,
              color: Colors.white, // Defina a cor do ícone como branca
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 89,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: azulPadrao,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                        'Item 1',
                        style: GoogleFonts.robotoSlab(
                          fontWeight: FontWeight.w900,
                          fontSize: 20.0,
                          color: azulPadrao,
                          letterSpacing: 2.0,
                        ),
                      ),
              onTap: () {
                // Adicione aqui a lógica para lidar com o clique em Item 1 do Drawer
              },
            ),
            ListTile(
              title: Text(
                        'Item 1',
                        style: GoogleFonts.robotoSlab(
                          fontWeight: FontWeight.w900,
                          fontSize: 20.0,
                          color: azulPadrao,
                          letterSpacing: 2.0,
                        ),
                      ),
              onTap: () {
                // Adicione aqui a lógica para lidar com o clique em Item 1 do Drawer
              },
            ),
            // Adicione mais itens do Drawer conforme necessário
          ],
        ),
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
                //LOGIN
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
                  child: Container(
                    child: Text(
                      'Cadastro Usuario',
                      style: GoogleFonts.robotoSlab(
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0,
                        color: azulPadrao,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ), //espaçamento
                //tipo usuario
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ListTile(
                    title: Text('Tipo de usuário'),
                    trailing: DropdownButton<String>(
                      value: _selectedRole,
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value;
                        });
                      },
                      dropdownColor: backgroundPadrao,
                      items: <String>['Admin', 'Aluno', 'Professor']
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                //CPF
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: azulPadrao),
                    ),
                    child: TextField(
                      controller: _cpfController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Digite o CPF',
                      ),
                    ),
                  ),
                ),
                //nome
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: azulPadrao),
                    ),
                    child: TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Digite o nome',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //email
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: azulPadrao),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Digite o email',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //telefone
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: azulPadrao),
                    ),
                    child: TextField(
                      controller: _telefoneController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Digite o telefone',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //SENHA
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
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
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            hintText: 'Digite sua senha',
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
                SizedBox(height: 10.0,),
                //SENHA
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
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
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            hintText: 'Confirme a senha',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                //BOTAO DE LOGIN
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 125.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
