import 'package:flutter/material.dart';

import '../models/Supplies.dart';

class SuppliesShowScreen extends StatelessWidget {
  const SuppliesShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
  Supplies supplie = ModalRoute.of(context)?.settings.arguments as Supplies;

    return Scaffold(
      appBar: AppBar(
        title: Text("Material ${supplie.name}")
      ),
      body:  Column
      (children: [
        Image.network(supplie.imageUrl),
        Text(supplie.name, style: TextStyle(fontSize: 20.0)),
        Text("R\$ ${supplie.price.toStringAsFixed(2)}", style: TextStyle(fontSize: 20.0)),
        Text(supplie.description, style: TextStyle(fontSize: 10.0))
      ]),

    );
  }
}