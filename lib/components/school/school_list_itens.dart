import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/School.dart';
import '../../providers/school_provider.dart';
import '../../routes/route.dart';

class SchoolListItens extends StatefulWidget {
  const SchoolListItens(this.school, this.contexts, {super.key});
  final School school;
  final BuildContext contexts;

  @override
  State<SchoolListItens> createState() => _SchoolListItensState();
}

class _SchoolListItensState extends State<SchoolListItens> {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<SchoolProvider>(context);
    provider.singleSchool = widget.school;
    return Column(
      children: [
        ListTile(
          leading: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => provider.removeSchool(widget.school)),
          title: Text("${widget.school.name}"),
          subtitle: Text("Particular"),
          onTap: () {
            Navigator.of(widget.contexts)
                .pushNamed(Routes.schoolShowScreen, arguments: provider);
          },
        ),
      ],
    );
  }
}
