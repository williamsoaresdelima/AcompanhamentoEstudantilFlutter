import 'package:acompanhamento_estudantil/components/school/school_list_itens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/School.dart';
import '../../providers/school_provider.dart';
import '../../services/school_service.dart';

class SchoolList extends StatelessWidget {
  const SchoolList(this.contexts,{super.key});

   final BuildContext contexts;

  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<SchoolProvider>(context);
    List<Widget> CreateTileProduct(List<School> schools)
    {
        return schools.map((school) => SchoolListItens(school, contexts)).toList();     
    }

    return FutureBuilder(
          future: provider.list(),
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