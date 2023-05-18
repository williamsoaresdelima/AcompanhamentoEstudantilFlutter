import 'package:acompanhamento_estudantil/screens/supplies_list_screen.dart';
import 'package:acompanhamento_estudantil/screens/supplies_show_screen.dart';
import 'package:flutter/material.dart';
import 'models/Supplies.dart';
import 'routes/route.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: SuppliesListScreen(_supplies),
      routes:{ 
        Routes.suppliesListScreen: (context) => SuppliesListScreen(),
        Routes.suppliesShowScreen: (context) => SuppliesShowScreen()
      }
    );
  }
}