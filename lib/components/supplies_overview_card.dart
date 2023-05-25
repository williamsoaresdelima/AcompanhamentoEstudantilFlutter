import 'package:acompanhamento_estudantil/providers/school_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Supplies.dart';

class SuppliesOverviewCard extends StatelessWidget {
  const SuppliesOverviewCard(this.supplie, {super.key});

  final Supplies supplie;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SchoolProvider>(context);
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Preço", style: TextStyle(fontSize: 25.0)),
        Column(
          children: [
            Text("Quant", style: TextStyle(fontSize: 25.0)),
            Text("${supplie.quant}", style: TextStyle(fontSize: 18.0))
          ],
        ),
        Column(
          children: [
            Text("R\$", style: TextStyle(fontSize: 25.0)),
            Text("R\$ ${supplie.price.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18.0))
          ],
        )
      ],
    ));
  }
}
