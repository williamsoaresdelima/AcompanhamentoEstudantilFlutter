import 'dart:io';

import 'package:acompanhamento_estudantil/models/Address.dart';
import 'package:acompanhamento_estudantil/services/school_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indexed/indexed.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../AppGlobalKeys.dart';
import '../components/school/school_grid_image.dart';
import '../models/School.dart';
import '../models/Users.dart';
import '../providers/school_provider.dart';
import '../providers/user_provider.dart';
import '../routes/route.dart';
import 'package:acompanhamento_estudantil_pk/acompanhamento_estudantil_pk.dart';

class SchoolInsertScreen extends StatefulWidget {
  const SchoolInsertScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SchoolInsertScreenState();
}

class _SchoolInsertScreenState extends State<SchoolInsertScreen> {
  @override
  void initState() {
    super.initState();
    getLocation().then((value) => _location.text = value);
  }

  List<File> _image = [];

  final _name = TextEditingController();
  final _location = TextEditingController();

  removeImage(File image) {
    List<File> newListImage = [];

    _image.forEach((element) {
      if (element != image) newListImage.add(element);
    });

    setState(() {
      _image = newListImage;
    });
  }

  Future<void> pickImage() async {
    final pickerImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickerImage != null) {
      setState(() {
        _image.add(File(pickerImage.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SchoolProvider>(context);
    Users users = ModalRoute.of(context)?.settings.arguments as Users;
    provider.user = users;

    Widget builderImage() {
      if (_image.length > 0)
        return SchoolGridImage(_image, removeImage);
      else
        return Text('');
    }

    void insertSchool() {
      List<String> imagesId = [];
      int error = 0;
      _image.forEach((element) {
        try {
          String id = Uuid().v4();
          final reference = FirebaseStorage.instance.ref('school/${id}.jpg');
          reference.putFile(element);
          imagesId.add(id);
        } catch (err) {
          error++;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Erro na Autenticação, Erro técnico: ${err}"),
            duration: Duration(seconds: 2),
          ));
        }
      });
      School newSchoool =
          School("0", _name.text, [], imagesId, _location.text, users.id);
      provider.insert(newSchoool);
      setState(() {
        provider.schools.add(newSchoool);
      });
      Navigator.of(context)
          .pushReplacementNamed(Routes.schoolListScreen, arguments: users);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Escola"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              key: AppSchoolInsertKeys.inputName,
              controller: _name,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              key: AppSchoolInsertKeys.inputLocation,
              controller: _location,
              decoration: InputDecoration(labelText: "Localização"),
            ),
            Center(
              child: IconButton(
                  key: AppSchoolInsertKeys.buttonAddImage,
                  onPressed: pickImage,
                  icon: const Icon(Icons.camera)),
            ),
            builderImage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                      key: AppSchoolInsertKeys.buttonCancel,
                      onPressed: () => {Navigator.pop(context)},
                      child: const Text("Cancelar")),
                ),
                ElevatedButton(
                    key: AppSchoolInsertKeys.buttonSave,
                    onPressed: () => insertSchool(),
                    child: const Text("Salvar")),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> getLocation() async {
    LocationData _locationData = await SchoolService().GetPermission();
    return LocationAdress()
        .getLocation(_locationData.latitude, _locationData.longitude);
  }
}
