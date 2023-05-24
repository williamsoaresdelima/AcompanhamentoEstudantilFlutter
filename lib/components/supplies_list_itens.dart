import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Supplies.dart';
import '../providers/supplies_provider.dart';
import '../routes/route.dart';

class SuppliesListItens extends StatelessWidget {
  const SuppliesListItens(this.supplie, this.contexts, {super.key});
 final Supplies supplie;
 final BuildContext contexts;

   String FormatSubtitle(Supplies supplie, int quant){
  return "R\$ ${supplie.price.toStringAsFixed(2)} - ${supplie.quant}";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SuppliesProvider>(context);
    return  ListTile(
                leading: IconButton(icon: Icon(Icons.delete), onPressed: () => 
                provider.removeItem(supplie)),
                title: Text("${supplie.name}"),
                subtitle: Text(FormatSubtitle(supplie, supplie.quant)),
                onTap: () {
                  Navigator.of(contexts).pushNamed(
                    Routes.suppliesShowScreen,
                    arguments: supplie);
                },
              );
  }
}