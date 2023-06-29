import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/Supplies.dart';

class SuppliesEditing extends StatefulWidget {
  SuppliesEditing(this.SetNewImage,this.Editing, this.Edit, this.inputSupplie, {super.key});

  Supplies inputSupplie;
  final Function? Editing;
  final Function? Edit;
  final Function? SetNewImage;

  @override
  State<SuppliesEditing> createState() => _SuppliesEditingState();
}

class _SuppliesEditingState extends State<SuppliesEditing> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _quant = TextEditingController();
  final _description = TextEditingController();
  File? image;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickerImage = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 100, maxWidth: 600);

    if (pickerImage != null) {
      setState(() {
        image = File(pickerImage.path);
      });
      widget.SetNewImage!(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    _name.text = widget.inputSupplie.name;
    _price.text = widget.inputSupplie.price.toStringAsFixed(2);
    _quant.text = widget.inputSupplie.quant.toString();
    _description.text = widget.inputSupplie.description;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: "Nome"),
          ),
          TextField(
            controller: _price,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Preço"),
          ),
          Center(
            child: IconButton(onPressed: pickImage, icon: const Icon(Icons.camera)),
          ),
          TextField(
            controller: _quant,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Quantidade"),
          ),
          TextField(
            controller: _description,
            decoration: InputDecoration(labelText: "Descrição"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    widget.Editing!(false);
                  },
                  child: const Text("Cancelar")),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ElevatedButton(
                    onPressed: () {
                      widget.Edit!(Supplies(
                          '0',
                          _name.text,
                          _description.text,
                          double.parse(_price.text),
                          '',
                          int.parse(_quant.text)), image);
                    },
                    child: const Text("Salvar")),
              )
            ],
          )
        ],
      ),
    );
  }
}
