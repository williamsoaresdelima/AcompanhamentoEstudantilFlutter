import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

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
  final _imageURL = TextEditingController(); 
  final _quant = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SchoolProvider>(context);
    School school = ModalRoute.of(context)?.settings.arguments as School;

  void updateSchool(School school) {
      school.supplies.add(
          Supplies(1, _name.text, _description.text, double.parse(_price.text), _imageURL.text, int.parse(_quant.text)
        ));
      provider.update(school);
      setState(() {
        provider.singleSchool = school;
      });
      Navigator.pop(context);
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
              controller: _name,
              decoration: InputDecoration(
                labelText: "Nome"
              ),
            ),
            TextField(
               controller: _price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Preço"
              ),
            ),
            TextField(
               controller: _description,
              decoration: InputDecoration(
                labelText: "description"
              ),
            ),
            TextField(
               controller: _imageURL,
              decoration: InputDecoration(
                labelText: "Url Imagem"
              ),
            ),
            TextField(
               controller: _quant,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantidade"
              ),
            ),
            ElevatedButton(
              onPressed: () => updateSchool(school), 
              child: const Text("Salvar")
            )
          ],
        ),
      ),
    );
  }
}