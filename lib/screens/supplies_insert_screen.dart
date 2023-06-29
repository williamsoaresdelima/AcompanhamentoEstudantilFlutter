import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../AppGlobalKeys.dart';
import '../models/School.dart';
import '../models/Supplies.dart';
import '../providers/school_provider.dart';
import '../routes/route.dart';
import '../services/school_service.dart';

class SuppliesInsertScreen extends StatefulWidget {
  const SuppliesInsertScreen({super.key});

  @override
  State<SuppliesInsertScreen> createState() => _SuppliesInsertScreenState();
}

class _SuppliesInsertScreenState extends State<SuppliesInsertScreen> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();
  final _quant = TextEditingController();
  bool _fileActive = false;
  File _image = File("");

  Future<void> pickImage() async {
    final pickerImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100, maxWidth: 600);

    if (pickerImage != null) {
      setState(() {
        _image = File(pickerImage.path);
        _fileActive = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    School school = ModalRoute.of(context)?.settings.arguments as School;


    void updateSchool() {
      final provider = Provider.of<SchoolProvider>(context);

      String idImage = Uuid().v4();
      bool error = false;
      try {
        final reference =
            FirebaseStorage.instance.ref('school/supplie/${idImage}.jpg');
        reference.putFile(_image);
      } catch (err) {
        error = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Erro na Autenticação, Erro técnico: ${err}"),
          duration: Duration(seconds: 2),
        ));
      }

      if (!error) {
        school.supplies.add(Supplies('1', _name.text, _description.text,
            double.parse(_price.text), idImage, int.parse(_quant.text)));
        provider.update(school);
        setState(() {
          provider.singleSchool = school;
        });
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Material Escolar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              key: AppSuppliesInsertKeys.inputName,
              controller: _name,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              key: AppSuppliesInsertKeys.inputPrice,
              controller: _price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Preço"),
            ),
            TextField(
              key: AppSuppliesInsertKeys.inputDescription,
              controller: _description,
              decoration: InputDecoration(labelText: "Descrição"),
            ),
            TextField(
              key: AppSuppliesInsertKeys.inputQuant,
              controller: _quant,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Quantidade"),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child:
            //       Image.file(_image, width: 300, height: 200, fit: BoxFit.fill),
            // ),
            Center(
              child: !_fileActive ? Padding(
                padding: const EdgeInsets.only(left: 70.0),
                  child: Row(
                    children: [         
                      IconButton(
                          key: AppSuppliesInsertKeys.buttonAddImage,
                          onPressed: pickImage, icon: const Icon(Icons.camera)), 
                          const Text("Selecione uma imagem")
                    ],
                  ),
                ) : IconButton(
                        key: AppSuppliesInsertKeys.buttonAddImage,
                        onPressed: pickImage, icon: const Icon(Icons.camera)),
              ),
            _fileActive
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.file(_image,
                        width: 300, height: 200, fit: BoxFit.fill),
                  )
                  : Text(""),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: ElevatedButton(
                        key: AppSuppliesInsertKeys.buttonCancel,
                        onPressed: () => {Navigator.pop(context)},
                        child: const Text("Cancelar")),
                  ),
                  ElevatedButton(
                      key: AppSuppliesInsertKeys.buttonUpdate,
                      onPressed: () => updateSchool(),
                      child: const Text("Salvar")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
