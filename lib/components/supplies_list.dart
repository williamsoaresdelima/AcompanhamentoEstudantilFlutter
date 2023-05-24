import 'package:acompanhamento_estudantil/components/supplies_list_itens.dart';
import 'package:acompanhamento_estudantil/services/supplies_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/School.dart';
import '../models/Supplies.dart';
import '../providers/supplies_provider.dart';

class SuppliesList extends StatelessWidget {
  const SuppliesList(this.contexts, this.supplies,{super.key});

  final List<Supplies> supplies;
   final BuildContext contexts;

  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<SuppliesProvider>(context);
    List<Widget> CreateTileProduct(List<Supplies> supplies)
    {
        return supplies.map((supplie) => SuppliesListItens(supplie, contexts)).toList();     
    }

    return  Expanded(
              child: ListView(
                children: CreateTileProduct(supplies)
              )
            ); 
  }
}