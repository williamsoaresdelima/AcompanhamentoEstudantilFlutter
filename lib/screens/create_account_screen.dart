import 'package:acompanhamento_estudantil_pk/acompanhamento_estudantil_pk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:location/location.dart';

import '../models/Users.dart';
import '../services/school_service.dart';
import '../services/user_service.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  var termsIsChecked = false;
  var _obscurePassword = true;
  var _obscureConfirmPassword = true;
  var _visibilityEyePassword = true;
  var _visibilityEyeConfirmPassword = true;

  void initState() {
    super.initState();
    getLocation().then((value) => _enderecoController.text = value);
  }

  void releasePassword() {
    setState(() {
      _visibilityEyePassword = _visibilityEyePassword ? false : true;
      _obscurePassword = _obscurePassword ? false : true;
    });
  }

  void releaseConfirmPassword() {
    setState(() {
      _visibilityEyeConfirmPassword =
          _visibilityEyeConfirmPassword ? false : true;
      _obscureConfirmPassword = _obscureConfirmPassword ? false : true;
    });
  }

  void createAccount() async {
    var textError = '';
    if (_emailController.text == '' || !_emailController.text.contains('@'))
      textError += 'email, ';
    if (_fullNameController.text == '') textError += 'nome completo, ';
    if (_userNameController.text == '') textError += 'nome de Usuário, ';
    if (_passwordController.text == '' ||
        _passwordController.text != _confirmPasswordController.text)
      textError += 'senha ou a senha e a confirmação estão divergente, ';
    if (!termsIsChecked) textError += 'termos de aceite, ';

    if (textError == '') {
      try {
        final FirebaseAuth auth = FirebaseAuth.instance;

        var userCreate = await auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        if (userCreate.user != null && userCreate.credential != null) {
          Users newUser = Users(
              '0',
              _emailController.text,
              _fullNameController.text,
              _userNameController.text,
              _enderecoController.text);

          UserService userService = UserService();
          await userService.insert(newUser);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Usuário criado com sucesso!"),
            duration: Duration(seconds: 4),
          ));

          Navigator.pop(context);
        }
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ocorreu algum erro na aplicação: ${err}"),
          duration: Duration(seconds: 4),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Ocorreu algum erro nos campos: ${textError} alguns campos são obrigatórios!"),
        duration: Duration(seconds: 4),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Conta"),
      ),
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
              padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Informações Pessoais',
                              style: TextStyle(
                                  fontSize: 25, color: Colors.black87),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                              style: const TextStyle(
                                  height: 1.0, color: Colors.black),
                              controller: _userNameController,
                              decoration:
                                  InputsDecoration.createInputsDecorationText(
                                      'Nome de Usuário')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                              style: const TextStyle(
                                  height: 1.0, color: Colors.black),
                              controller: _fullNameController,
                              decoration:
                                  InputsDecoration.createInputsDecorationText(
                                      'Nome Completo')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                              style: const TextStyle(
                                  height: 1.0, color: Colors.black),
                              controller: _enderecoController,
                              decoration:
                                  InputsDecoration.createInputsDecorationText(
                                      'Endereço')),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Informações de Usuário',
                              style: TextStyle(
                                  fontSize: 25, color: Colors.black87),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                              style: const TextStyle(
                                  height: 1.0, color: Colors.black),
                              controller: _emailController,
                              decoration:
                                  InputsDecoration.createInputsDecorationText(
                                      'Email')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Indexer(children: [
                            Indexed(
                              index: 22,
                              child: TextField(
                                  obscureText: _obscurePassword,
                                  style: const TextStyle(
                                      height: 1.0, color: Colors.black),
                                  controller: _passwordController,
                                  decoration: InputsDecoration
                                      .createInputsDecorationText('Senha')),
                            ),
                            InputsDecoration.createVisibilityPassword(
                                _visibilityEyePassword,
                                releasePassword,
                                9.0,
                                10.0,
                                27.0,
                                27.0)
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Indexer(
                            children: [
                              Indexed(
                                index: 22,
                                child: TextField(
                                    obscureText: _obscureConfirmPassword,
                                    style: const TextStyle(
                                        height: 1.0, color: Colors.black),
                                    controller: _confirmPasswordController,
                                    decoration: InputsDecoration
                                        .createInputsDecorationText(
                                            'Confirmar Senha')),
                              ),
                              InputsDecoration.createVisibilityPassword(
                                  _visibilityEyeConfirmPassword,
                                  releaseConfirmPassword,
                                  9.0,
                                  10.0,
                                  27.0,
                                  27.0)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListTile(
                        leading: Checkbox(
                          checkColor: Colors.white,
                          value: termsIsChecked,
                          shape: CircleBorder(),
                          onChanged: (bool? value) {
                            setState(() {
                              termsIsChecked = value!;
                            });
                          },
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Column(children: [
                            Text('Eu aceito'),
                            Row(
                              children: [
                                InkResponse(
                                  onTap: () => {},
                                  child: const Text(
                                    'Termos e Política Privacidade',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                const Text(' do site')
                              ],
                            ),
                          ]),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ElevatedButton(
                              onPressed: () => {Navigator.pop(context)},
                              child: const Text("Cancelar")),
                        ),
                        ElevatedButton(
                            onPressed: () => createAccount(),
                            child: const Text("Salvar")),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> getLocation() async {
    LocationData _locationData = await SchoolService().GetPermission();
    print('testeeee');
    return LocationAdress()
        .getLocation(_locationData.latitude, _locationData.longitude);
  }
}
