import 'package:acompanhamento_estudantil/components/supplies_list_itens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Supplies.dart';
import '../providers/supplies_provider.dart';

class SuppliesList extends StatelessWidget {
  const SuppliesList(this.contexts,{super.key});

   final BuildContext contexts;

  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<SuppliesProvider>(context);
    List<Widget> CreateTileProduct()
    {
        return provider.supplies.map((supplie) => SuppliesListItens(supplie, contexts)).toList();     
    }

    return  provider.supplies.isNotEmpty ? Expanded(
      child:  ListView (
                  children : CreateTileProduct()))     
                  : Text("Nenhum item encontrado!");
  }
}