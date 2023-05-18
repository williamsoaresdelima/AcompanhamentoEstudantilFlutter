import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/supplies_list.dart';
import '../components/supplies_list_itens.dart';
import '../components/supplies_overview_card.dart';
import '../models/Supplies.dart';
import '../providers/supplies_provider.dart';
import '../routes/route.dart';

class SuppliesListScreen extends StatefulWidget {
  SuppliesListScreen({super.key});

  @override
  State<SuppliesListScreen> createState() => _SuppliesListScreenState();
}

class _SuppliesListScreenState extends State<SuppliesListScreen>
{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Acompanhamento Estudantil"),
        ),
        body: 
        ChangeNotifierProvider(
          create: (context) => SuppliesProvider(),
          child: Column(children: [
            SuppliesOverviewCard(),
            SuppliesList(context)
          ],) 
        )
      ),
    );
  }
}