import 'dart:convert';
import 'package:acompanhamento_estudantil/providers/school_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/School.dart';
import '../models/ScreenArguments.dart';
import '../models/Supplies.dart';
import '../routes/route.dart';
import '../services/school_service.dart';

class SuppliesListItens extends StatelessWidget {
  const SuppliesListItens(this.school, this.supplie, this.contexts,
      {super.key});
  final Supplies supplie;
  final School school;
  final BuildContext contexts;

  String FormatSubtitle(Supplies supplie, int quant) {
    return "R\$ ${supplie.price.toStringAsFixed(2)} - ${supplie.quant}";
  }

  void removeItem(
      School schoolEdit, Supplies supplieEdit, BuildContext context) {
    List<Supplies> newListSupplies = [];
    schoolEdit.supplies.forEach((Supplies element) =>
        {if (element.id != supplie.id) newListSupplies.add(element)});
    schoolEdit.supplies = newListSupplies;

    SchoolService().Update(schoolEdit.id, jsonEncode(school.toJson()));

    Navigator.of(context)
        .pushNamed(Routes.schoolShowScreen, arguments: schoolEdit);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SchoolProvider>(context);
    provider.singleSchool = this.school;
    return ListTile(
      leading: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => removeItem(school, supplie, context)),
      title: Text("${supplie.name}"),
      subtitle: Text(FormatSubtitle(supplie, supplie.quant)),
      onTap: () {
        Navigator.of(contexts).pushNamed(Routes.suppliesShowScreen,
            arguments: ScreenArguments(school, supplie));
      },
    );
  }
}
