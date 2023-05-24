import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/supplies_list.dart';
import '../components/supplies_overview_card.dart';
import '../models/School.dart';
import '../providers/supplies_provider.dart';
import '../routes/route.dart';

class SchoolShowScreen extends StatelessWidget {
  const SchoolShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
  School school = ModalRoute.of(context)?.settings.arguments as School;
    return Scaffold(
      appBar: AppBar(
        title: Text("${school.name}")
      ),
      body:  ChangeNotifierProvider(
          create: (context) => SuppliesProvider(),
          child: Column(children: [
            Text("${school.name}"),
            SuppliesList(context, school.supplies)
          ],) 
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>{
          Navigator.of(context).pushNamed(Routes.suppliesInsertScreen,arguments: school)
        })

    );
  }
}