import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
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
  List<TextEditingController> _controllers = [];

  getMyLocation() {
    getLocation().then((value) => setState(() {
          _getLocation.text = value;
        }));
  }

  removeInput() {
    var count = 1;
    List<TextEditingController> newcontrollers = [];
    _controllers.forEach((element) {
      if (count < _controllers.length) newcontrollers.add(element);

      count++;
    });

    setState(() {
      _controllers = newcontrollers;
    });
  }

  addInput() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  Widget builderGetLocation() {
    TextEditingController newLocation = TextEditingController();
    if (_getLocation.text.length > 0)
      newLocation = _getLocation;
    else
      newLocation = _location;

    return ListTile(
      trailing: IconButton(
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

  @override
  Widget build(BuildContext context) {
    School school = ModalRoute.of(context)?.settings.arguments as School;
    final provider = Provider.of<SchoolProvider>(context);
    provider.singleSchool = school;

    _location.text = provider.singleSchool.location;
    _name.text = provider.singleSchool.name;

    void UpdateSchool() {
      List<String> images = [];
      _controllers.forEach((element) => {images.add(element.text)});

      school.name = _name.text;
      school.imageUrl = images;

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

    List<Widget> builderInputImageUrl() {
      if (_controllers.length == 0) {
        List<TextEditingController> QuantControlers = [];
        school.imageUrl.forEach((element) {
          TextEditingController controler = TextEditingController();

          controler.text = element;
          QuantControlers.add(controler);
        });

        _controllers = QuantControlers;
      }

      return _controllers
          .map((controler) => TextField(
                controller: controler,
                decoration: InputDecoration(labelText: "Url Imagem"),
              ))
          .toList();
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
              controller: _name,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            builderGetLocation(),
            Column(
              children: builderInputImageUrl(),
            ),
            ListTile(
                leading: IconButton(
                    icon: Icon(Icons.delete), onPressed: () => removeInput()),
                trailing: IconButton(
                    icon: Icon(Icons.add), onPressed: () => addInput())),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                      onPressed: () => {Navigator.pop(context)},
                      child: const Text("Cancer")),
                ),
                ElevatedButton(
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
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) Future.value("");
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) Future.value("");
    }

    _locationData = await location.getLocation();

    try {
      Map<String, dynamic> json = await SchoolService().getAddress(_locationData.latitude, _locationData.longitude);
      Address modelAdress = Address("", "", "", "", "", "");
      modelAdress.createAdress(json);
      return "${modelAdress.street}, ${modelAdress.district}, ${modelAdress.city} - ${modelAdress.uf}, ${modelAdress.postalCode} - ${modelAdress.country}";
    } catch (err) {
      print(err);
    }

    return "${_locationData.latitude} - ${_locationData.longitude}";
  }
}
