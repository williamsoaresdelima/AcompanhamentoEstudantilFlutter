import 'dart:io';
import 'dart:typed_data';

import 'package:acompanhamento_estudantil_pk/acompanhamento_estudantil_pk.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../AppGlobalKeys.dart';
import '../components/school/school_grid_image.dart';
import '../models/Address.dart';
import '../models/School.dart';
import '../providers/school_provider.dart';
import '../services/school_service.dart';

class SchoolEditScreen extends StatefulWidget {
  const SchoolEditScreen({super.key});

  @override
  State<SchoolEditScreen> createState() => _SchoolEditScreenState();
}

class _SchoolEditScreenState extends State<SchoolEditScreen> {
  final _name = TextEditingController();
  final _location = TextEditingController();
  final _getLocation = TextEditingController();
  List<File> _image = [];
  List<String> teste = [];
  List<String> urls = [];
  bool checking = false;
  bool firstImage = true;

  getMyLocation() {
    getLocation().then((value) => setState(() {
          _getLocation.text = value;
        }));
  }

  Widget builderGetLocation() {
    TextEditingController newLocation = TextEditingController();
    if (_getLocation.text.length > 0)
      newLocation = _getLocation;
    else
      newLocation = _location;

    return ListTile(
      trailing: IconButton(
          key: AppSchoolEditKeys.buttonGetLocation,
          icon: Icon(
            Icons.gps_fixed,
          ),
          onPressed: () => getMyLocation()),
      title: TextField(
        controller: newLocation,
        decoration: InputDecoration(labelText: "Localização"),
      ),
    );
  }

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

  Widget builderImage() {
    if (_image.length > 0)
      return SchoolGridImage(_image, removeImage);
    else
      return Text('');
  }

  void ImagesIdtoFile(String imagesId) async {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      if (_image.length < imagesId.length) {
        String idDirectory = Uuid().v4();
        File file = File('');
        final reference =
            FirebaseStorage.instance.ref('school/${imagesId}.jpg');
            print('TESTE');
                 print(reference);
        try {
          var directory = await Directory(
                  '/data/user/0/br.ace.lima.acompanhamento_estudantil/cache/${idDirectory}')
              .create(recursive: true);
          var bytes = await reference.getData();

          file = await File('${directory.path}/${imagesId}.jpg')
              .writeAsBytes(bytes!);
          setState(() {
            _image.add(file);
          });
        } catch (err) {
          print(err);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    teste = [];
    School school = ModalRoute.of(context)?.settings.arguments as School;
    final provider = Provider.of<SchoolProvider>(context);
    provider.singleSchool = school;
    teste = provider.singleSchool.imageUrl;
    _location.text = provider.singleSchool.location;
    _name.text = provider.singleSchool.name;

    if (provider.singleSchool.imageUrl.length > 0 && firstImage) {
      setState(() {
        firstImage = false;
      });
      for (var id in provider.singleSchool.imageUrl) {
        ImagesIdtoFile(id);
      }
    }

    void UpdateSchool() {
      List<String> imagesId = [];

      int error = 0;
      _image.forEach((element) {
          var teste = provider.singleSchool.imageUrl.where((image) => image == element).toList();
          
        try {
          if (teste.length == 0 || teste == null) {
            String id = Uuid().v4();
            final reference = FirebaseStorage.instance.ref('school/${id}.jpg');
            reference.putFile(element);
            imagesId.add(id);
          }
          else
            imagesId.add(teste.first);
        } catch (err) {}
      });

      school.name = _name.text;
      school.imageUrl = imagesId;

      if (_getLocation.text.length > 0)
        school.location = _getLocation.text;
      else
        school.location = _location.text;

      provider.update(school);
      setState(() {
        provider.singleSchool = school;
      });
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Editando ${school.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              key: AppSchoolEditKeys.inputName,
              controller: _name,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            builderGetLocation(),
            Center(
              child: IconButton(
                  key: AppSchoolEditKeys.buttonAddImage,
                  onPressed: pickImage, icon: const Icon(Icons.camera)),
            ),
            builderImage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                      key: AppSchoolEditKeys.buttonCancel,
                      onPressed: () => {Navigator.pop(context)},
                      child: const Text("Cancelar")),
                ),
                ElevatedButton(
                    key: AppSchoolEditKeys.buttonSave,
                    onPressed: () => UpdateSchool(),
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
    return LocationAdress().getLocation(_locationData.latitude, _locationData.longitude);
  }
}
