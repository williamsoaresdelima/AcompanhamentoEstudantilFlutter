import 'package:flutter/material.dart';
import '../models/Supplies.dart';

class SuppliesEditing extends StatelessWidget {
  SuppliesEditing(this.Editing, this.Edit, this.inputSupplie, {super.key});

  Supplies inputSupplie;
  final Function? Editing;
  final Function? Edit;
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _imageURL = TextEditingController();
  final _quant = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _name.text = inputSupplie.name;
    _price.text = inputSupplie.price.toStringAsFixed(2);
    _imageURL.text = inputSupplie.imageUrl;
    _quant.text = inputSupplie.quant.toString();
    _description.text = inputSupplie.description;

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
          TextField(
            controller: _imageURL,
            decoration: InputDecoration(labelText: "Url Imagem"),
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
                    Editing!(false);
                  },
                  child: const Text("Cancelar")),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ElevatedButton(
                    onPressed: () {
                      Edit!(Supplies(
                          0,
                          _name.text,
                          _description.text,
                          double.parse(_price.text),
                          _imageURL.text,
                          int.parse(_quant.text)));
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
