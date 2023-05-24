import 'package:acompanhamento_estudantil/components/supplies_list_itens.dart';
import 'package:acompanhamento_estudantil/providers/school_provider.dart';
import 'package:acompanhamento_estudantil/services/supplies_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/School.dart';
import '../models/Supplies.dart';
import '../providers/supplies_provider.dart';

class SuppliesList extends StatelessWidget {
  const SuppliesList(this.contexts, this.school,{super.key});

  final School school;
   final BuildContext contexts;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SchoolProvider>(context);
    provider.singleSchool = school;
    List<Widget> CreateTileProduct(School school)
    {
        return provider.singleSchool.supplies.map((supplie) => SuppliesListItens(school, supplie, contexts)).toList();     
    }

    return  Expanded(
              child: ListView(
                children: CreateTileProduct(school)
              )
            ); 
  }
}