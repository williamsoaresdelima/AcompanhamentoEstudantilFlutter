import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes/route.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> Entrar(BuildContext context) async {
    auth.signOut();
    if(auth.currentUser != null)
      Navigator.of(context).pushNamed(Routes.schoolListScreen);
    else
      Navigator.of(context).pushNamed(Routes.signInScreen);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: const [
                    Center(
                      child: Text("Bem vindo ao controle de",
                          style: TextStyle(fontSize: 23.0)),
                    ),
                    Center(
                      child: Text("Materias Escolares",
                          style: TextStyle(fontSize: 23.0)),
                    )
                  ],
                )),
          ),
          ElevatedButton(
              onPressed: () => Entrar(context),
              child: const Text("Entrar"))
        ],
      ),
    ));
  }
}
