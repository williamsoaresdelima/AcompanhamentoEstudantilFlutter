import 'package:acompanhamento_estudantil/components/supplies_list_itens.dart';
import 'package:acompanhamento_estudantil/services/supplies_service.dart';
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
    List<Widget> CreateTileProduct(List<Supplies> supplies)
    {
        return supplies.map((supplie) => SuppliesListItens(supplie, contexts)).toList();     
    }

    return FutureBuilder(
          future: SuppliesService().list(),
          builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator()
            );
          } else if (snapshot.hasError){
            return const Center (
              child: Text("Erro ao consultar dados.")
            );
          }
          else if (snapshot.hasData) {
            final list = snapshot.data;
            if(list != null && list.isNotEmpty){
              return    Expanded(
                child: ListView(
                  children: CreateTileProduct(list)
                )
              );
            }
            else{
              return const Center(
                child: Text("Nenhum material cadastrado.")
              );
            };
          }   
          else{
              return const Center(
                child: Text("Nenhum material cadastrado.")
              );
          }        
      });
  }
}