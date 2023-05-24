import 'dart:convert';

import 'package:acompanhamento_estudantil/services/school_service.dart';
import 'package:flutter/material.dart';

import '../models/School.dart';
import '../models/Supplies.dart';
import '../routes/route.dart';

class SuppliesProvider with ChangeNotifier{
  SuppliesProvider(this.supplies);
  List<Supplies> supplies = [
  ];


    void addItem(Supplies supplies){
      supplies.quant++;
      notifyListeners();
    }

  
  String countItens() => supplies.fold(0 , (acc, p) => acc + p.quant).toString();
  String totalPrice() => supplies.fold(0.0 , (acc, p) => acc + p.price * p.quant).toStringAsFixed(2);
}