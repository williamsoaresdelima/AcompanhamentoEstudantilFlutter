import 'package:flutter/material.dart';

import '../routes/route.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.schoolListScreen);
              },
              child: const Text("Entrar"))
        ],
      ),
    ));
  }
}
