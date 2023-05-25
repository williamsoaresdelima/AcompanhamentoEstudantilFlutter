import 'package:acompanhamento_estudantil/components/supplies_list_itens.dart';
import 'package:acompanhamento_estudantil/providers/school_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/School.dart';

class SuppliesList extends StatelessWidget {
  const SuppliesList(this.contexts, this.school, {super.key});

  final School school;
  final BuildContext contexts;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SchoolProvider>(contexts);
    provider.singleSchool = school;
    List<Widget> CreateTileProduct(School school) {
      if (school.supplies.length == 0)
        return [
          Center(
              child: Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Text("Nenhum material cadastrado."),
          ))
        ];
      else
        return provider.singleSchool.supplies
            .map((supplie) => SuppliesListItens(school, supplie, contexts))
            .toList();
    }

    return Expanded(child: ListView(children: CreateTileProduct(school)));
  }
}
