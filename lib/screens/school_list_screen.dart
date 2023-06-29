import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AppGlobalKeys.dart';
import '../components/school/school_list.dart';
import '../providers/school_provider.dart';
import '../routes/route.dart';

class SchoolListScreen extends StatefulWidget {
  SchoolListScreen({super.key});

  @override
  State<SchoolListScreen> createState() => _SchoolListScreenState();
}

class _SchoolListScreenState extends State<SchoolListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Acompanhamento Estudantil"),
        ),
        body: ChangeNotifierProvider(
            create: (context) => SchoolProvider(),
            child: Column(
              children: [SchoolList(context, key: AppSchoolListKeys.schoolList)],
            )),
        floatingActionButton: FloatingActionButton(
            key: AppSchoolListKeys.addButtonSchool,
            child: Icon(Icons.add),
            onPressed: () =>
                {Navigator.of(context).pushNamed(Routes.schoolInsertScreen)}));
  }
}
