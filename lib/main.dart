import 'package:acompanhamento_estudantil/providers/school_provider.dart';
import 'package:acompanhamento_estudantil/screens/home_screen.dart';
import 'package:acompanhamento_estudantil/screens/school_list_screen.dart';
import 'package:acompanhamento_estudantil/screens/school_show_screen.dart';
import 'package:acompanhamento_estudantil/screens/supplies_list_screen.dart';
import 'package:acompanhamento_estudantil/screens/supplies_show_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/Supplies.dart';
import 'routes/route.dart';
import 'screens/supplies_insert_screen.dart';

void main() {
  runApp(  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SchoolProvider()),
      ],
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: SuppliesListScreen(_supplies),

      routes:{ 
        // Routes.schoolListScreen: (context) => SuppliesListScreen(),
        Routes.suppliesShowScreen: (context) => SuppliesShowScreen(),
        Routes.suppliesInsertScreen: (context) => SuppliesInsertScreen(),
        Routes.schoolShowScreen: (context) => SchoolShowScreen(),
        Routes.schoolListScreen: (context) => SchoolListScreen(),
        Routes.homeScreen: (context) => HomeScreen()
      }
    );
  }
}