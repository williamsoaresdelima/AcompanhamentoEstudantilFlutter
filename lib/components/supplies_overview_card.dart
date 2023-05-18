import 'package:acompanhamento_estudantil/providers/supplies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Supplies.dart';

class SuppliesOverviewCard extends StatelessWidget {
  const SuppliesOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SuppliesProvider>(context);
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total",
          style: TextStyle(fontSize: 25.0)),
          Column(
            children: [
              Text("Quant",
              style: TextStyle(fontSize: 25.0)),
              Text(provider.countItens(),
              style: TextStyle(fontSize: 18.0))
            ],
          ),
          Column(
            children: [
              Text("R\$",
              style: TextStyle(fontSize: 25.0)),
              Text(provider.totalPrice(),
              style: TextStyle(fontSize: 18.0))
            ],
          )
        ],
      )
    );
  }
}