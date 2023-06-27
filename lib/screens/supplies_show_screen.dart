import 'dart:io';

import 'package:acompanhamento_estudantil/models/ScreenArguments.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../components/supplies_editing.dart';
import '../components/supplies_overview_card.dart';
import '../models/School.dart';
import '../models/Supplies.dart';
import '../providers/school_provider.dart';

class SuppliesShowScreen extends StatefulWidget {
  SuppliesShowScreen({super.key});

  @override
  State<SuppliesShowScreen> createState() => _SuppliesShowScreenState();
}

class _SuppliesShowScreenState extends State<SuppliesShowScreen> {
  final firebaseStorage = FirebaseStorage.instance;
  File _newImage = File('');
  bool imageEdited = false;

  @override
  Widget build(BuildContext context) {
    ScreenArguments screenArguments =
        ModalRoute.of(context)?.settings.arguments as ScreenArguments;

    final Supplies supplie = screenArguments.supplie;
    final School singleSchool = screenArguments.singleSchool;
    final provider = Provider.of<SchoolProvider>(context);

    provider.supplie = supplie;

    final reference =
        firebaseStorage.ref('school/supplie/${provider.supplie.imageUrl}.jpg');

    void Editing(bool val) {
      setState(() {
        provider.editing = val;
      });
    }

    void SetNewImage(File newImage) {
      setState(() {
        _newImage = newImage;
        imageEdited = true;
      });
      print(imageEdited);
    }

    Widget GetImage() {
      if (provider.supplie.imageUrl.length > 35 && imageEdited == false) {
        return FutureBuilder(
            future: reference.getDownloadURL(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const Center(child: CircularProgressIndicator());
              else if (snapshot.hasError)
                return const Center(child: Text("Erro ao consultar dados."));
              else if (snapshot.hasData) {
                final list = snapshot.data;
                if (list != null && list.isNotEmpty)
                  return Image.network(snapshot.data!,
                      width: 400, height: 350, fit: BoxFit.fill);
                else
                  return const Center(
                      child: Text("Nenhum material cadastrado."));
              } else
                return const Center(child: Text("Nenhum material cadastrado."));
            });
      } else if (imageEdited == true)
        return Image.file(_newImage, width: 400, height: 350, fit: BoxFit.fill);
      else
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: const Text('Nenhuma imagem encontrada'),
        );
    }

    void Edit(Supplies newSupplie, File? image) async {
      String idImage = Uuid().v4();
      bool error = false;
      try {
        final reference =
            FirebaseStorage.instance.ref('school/supplie/${idImage}.jpg');
        reference.putFile(image!);
      } catch (err) {
        error = true;
      }

      if (!error)
        newSupplie.imageUrl = idImage;
      else 
        newSupplie.imageUrl = supplie.imageUrl;

        provider.UpdateSupplie(newSupplie, singleSchool);
        setState(() {
          provider.supplie = newSupplie;
        });
        Navigator.pop(context, {'school': provider.singleSchool});
    }

    dynamic VerifyFloatingButton() {
      if (!provider.editing) {
        return FloatingActionButton(
            child: Icon(Icons.edit), onPressed: () => {Editing(true)});
      } else
        return null;
    }

    dynamic VerifyInputs() {
      if (provider.editing) {
        return SuppliesEditing(SetNewImage, Editing, Edit, supplie);
      } else
        return null;
    }

    return Scaffold(
        appBar: AppBar(title: Text("Material ${provider.supplie.name}")),
        body: ChangeNotifierProvider(
          create: (context) => SchoolProvider(),
          child: SingleChildScrollView(
            child: Column(children: [
              GetImage(),
              SuppliesOverviewCard(provider.supplie),
              Padding(
                child: VerifyInputs(),
                padding: EdgeInsets.only(
                  top: 20,
                ),
              )
            ]),
          ),
        ),
        floatingActionButton: VerifyFloatingButton());
  }
}
