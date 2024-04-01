import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUser extends StatelessWidget{

  final String documentId;

  GetUser({required this.documentId});

  @override
  Widget build(BuildContext context){
    
    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

    return FutureBuilder<DocumentSnapshot>(
      future: usuarios.doc(documentId).get(),
      builder: ((context, snapshot){
        
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            'Nome: ${data['nome']} ${data['sobrenome']},'
            '\nNascido em: ${data['data nascimento']},'
            '\nTelefone: ${data['telefone']},'
            '\nEmail: ${data['email']},'
          );
        }return Text('loading..');
      }),
    );
  }
}