import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../AppGlobalKeys.dart';
import '../routes/route.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> Login() async {
      final FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      _loading = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      if (auth.currentUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Usuário Autenticado!"),
          duration: Duration(seconds: 2),
        ));

        Navigator.of(context).pushNamed(Routes.schoolListScreen);
      } 
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Erro na Autenticação"),
          duration: Duration(seconds: 4),
        ));
      }

      setState(() {
        _loading = false;
      });
    } 
    catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erro na Autenticação, Erro técnico: ${err}"),
        duration: Duration(seconds: 4),
      ));

      print(err);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
            child: Column(
              children: [
                TextField(
                  key: AppSignInKeys.inputEmailKey,
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "E-mail"),
                ),
                TextField(
                  key: AppSignInKeys.inputPasswordKey,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Senha"),
                ),
                _loading
                    ? const CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            key: AppSignInKeys.buttonKey,
                            onPressed: () => {},
                            child: const Text("Entrar")),
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 250, top: 20),
            child: InkWell(
              key: AppSignInKeys.buttonCreateAccountKey,
              onTap: () {
                 Navigator.of(context).pushNamed(Routes.createAccountScreen);
              },
              child: const Text("Criar Conta"),
            ),
          )
        ],
      ),
    );
  }
}
