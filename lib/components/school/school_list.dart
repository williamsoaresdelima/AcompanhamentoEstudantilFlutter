import 'package:acompanhamento_estudantil/components/school/school_list_itens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/School.dart';
import '../../models/Users.dart';
import '../../providers/school_provider.dart';

class SchoolList extends StatelessWidget {
  const SchoolList(this.contexts,this.users, {super.key});

  final BuildContext contexts;
  final Users users;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SchoolProvider>(context);
    provider.user = users;

    List<Widget> CreateTileProduct(List<School> schools) {
      return provider.schools
          .map((school) => SchoolListItens(school, contexts))
          .toList();
    }

    Future<List<School>> list() async {
      var schools = await provider.list();
      schools = schools.where((element) => element.userId == users.id).toList();
      return schools;
    }

    return FutureBuilder(
        future: list(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao consultar dados."));
          } else if (snapshot.hasData) {
            final list = snapshot.data;
            if (list != null && list.isNotEmpty) {
              return Expanded(
                  child: ListView(children: CreateTileProduct(list)));
            } else {
              return const Center(child: Text("Nenhum material cadastrado."));
            }
            ;
          } else {
            return const Center(child: Text("Nenhum material cadastrado."));
          }
        });
  }
}
