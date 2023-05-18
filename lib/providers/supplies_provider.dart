import 'package:flutter/material.dart';

import '../models/Supplies.dart';

class SuppliesProvider with ChangeNotifier{
  
  List<Supplies> supplies = [
    Supplies(1, "Caneta", "Caneta Azul", 3.0, 
    "https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg", 2),
    Supplies(2, "Caderno", "Caderno de 10 matérias", 15.0, 
    "https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg", 3)
  ];
  

    void addItem(Supplies supplies){
      supplies.quant++;
      notifyListeners();
  }

   void removeItem(Supplies supplies){
    if(supplies.quant > 0){
          supplies.quant--;
           notifyListeners();
    }
  }

  
  String countItens() => supplies.fold(0 , (acc, p) => acc + p.quant).toString();
  String totalPrice() => supplies.fold(0.0 , (acc, p) => acc + p.price * p.quant).toStringAsFixed(2);
}