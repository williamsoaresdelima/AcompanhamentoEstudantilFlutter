import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

import '../AppGlobalKeys.dart';
import '../routes/route.dart';
import '../services/user_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  bool _obscurePassword = true;
  bool _visibilityEye = true;

  Future<void> Login(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      _loading = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      if (auth.currentUser != null) {
           UserService userService = UserService();
           var users = await userService.list();
           var myUser = users.where((element) => element.email == email).first;


        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Usuário Autenticado!"),
          duration: Duration(seconds: 2),
        ));

        Navigator.of(context).pushNamed(Routes.schoolListScreen, arguments: myUser);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Erro na Autenticação"),
          duration: Duration(seconds: 4),
        ));
      }

      setState(() {
        _loading = false;
      });
    } catch (err) {
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

  void releasePassword() {
    setState(() {
      _obscurePassword = _obscurePassword ? false : true;
      _visibilityEye = _visibilityEye ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.lightBlue.shade200,
            Colors.lightGreen.shade200,
            Colors.lightBlue.shade200,
          ],
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 150, right: 20),
              child: Column(
                children: [
                  Center(
                      child: Image.asset(
                    'assets/images/user.png',
                    width: 100,
                    height: 100,
                  )),
                  TextField(
                    key: AppSignInKeys.inputEmailKey,
                    controller: _emailController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        label: Icon(
                          Icons.email_outlined,
                          size: 35,
                        )),
                  ),
                  Indexer(children: [
                    Indexed(
                      index: 22,
                      child: TextField(
                        key: AppSignInKeys.inputPasswordKey,
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            label: Icon(Icons.lock_outline, size: 35)),
                      ),
                    ),
                    Indexed(
                      index: 100,
                      child: Positioned(
                          width: 27,
                          height: 27,
                          right: 5.0,
                          top: 10.0,
                          child: IconButton(
                              onPressed: releasePassword,
                              icon: _visibilityEye
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off))),
                    ),
                  ]),
                  _loading
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ))),
                                key: AppSignInKeys.buttonKey,
                                onPressed: () => Login(context),
                                child: const Text("Login")),
                          ),
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
      ),
    );
  }
}
