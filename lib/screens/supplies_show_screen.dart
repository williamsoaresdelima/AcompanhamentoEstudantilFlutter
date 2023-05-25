import 'package:acompanhamento_estudantil/models/ScreenArguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/supplies_editing.dart';
import '../components/supplies_overview_card.dart';
import '../models/School.dart';
import '../models/Supplies.dart';
import '../providers/school_provider.dart';

class SuppliesShowScreen extends StatefulWidget {
  SuppliesShowScreen({super.key});

  @override
  State<SuppliesShowScreen> createState() => _SuppliesShowScreenState();
}

class _SuppliesShowScreenState extends State<SuppliesShowScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenArguments screenArguments =
        ModalRoute.of(context)?.settings.arguments as ScreenArguments;

    final Supplies supplie = screenArguments.supplie;
    final School singleSchool = screenArguments.singleSchool;
    final provider = Provider.of<SchoolProvider>(context);

    provider.supplie = supplie;

    void Editing(bool val) {
      setState(() {
        provider.editing = val;
      });
    }

    void Edit(Supplies newSupplie) {
      if (newSupplie.imageUrl == "") newSupplie.imageUrl = supplie.imageUrl;

      provider.UpdateSupplie(newSupplie, singleSchool);
      setState(() {
        provider.supplie = newSupplie;
      });
      Navigator.pop(context, {'school': provider.singleSchool});
    }

    dynamic VerifyFloatingButton() {
      if (!provider.editing) {
        return FloatingActionButton(
            child: Icon(Icons.edit), onPressed: () => {Editing(true)});
      } else
        return null;
    }

    dynamic VerifyInputs() {
      if (provider.editing) {
        return SuppliesEditing(Editing, Edit, supplie);
      } else
        return null;
    }

    return Scaffold(
        appBar: AppBar(title: Text("Material ${provider.supplie.name}")),
        body: ChangeNotifierProvider(
          create: (context) => SchoolProvider(),
          child: SingleChildScrollView(
            child: Column(children: [
              Image.network(provider.supplie.imageUrl),
              SuppliesOverviewCard(provider.supplie),
              Padding(
                child: VerifyInputs(),
                padding: EdgeInsets.only(
                  top: 20,
                ),
              )
            ]),
          ),
        ),
        floatingActionButton: VerifyFloatingButton());
  }
}
