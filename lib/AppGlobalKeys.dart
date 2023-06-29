import 'package:flutter/material.dart';

class AppSignInKeys {
   static final inputEmailKey = GlobalKey();
   static final inputPasswordKey = GlobalKey();
   static final buttonKey = GlobalKey();
  static final buttonCreateAccountKey = GlobalKey();
}

class AppSchoolListKeys {
   static final schoolList = GlobalKey();
   static final addButtonSchool = GlobalKey();
}

class AppSuppliesInsertKeys {
   static final inputName = GlobalKey();
   static final inputPrice = GlobalKey();
   static final inputDescription = GlobalKey();
   static final inputQuant = GlobalKey();
   static final buttonAddImage = GlobalKey();
   static final buttonUpdate = GlobalKey();
   static final buttonCancel = GlobalKey();
}

class AppSchoolShowKeys {
  static final buttonEditSchool = GlobalKey();
  static final carouselImage = GlobalKey();
  static final buttonAddSupplies = GlobalKey();
}

class AppSchoolInsertKeys {
  static final inputName = GlobalKey();
  static final inputLocation = GlobalKey();
  static final buttonAddImage = GlobalKey();
  static final buttonCancel = GlobalKey();
  static final buttonSave = GlobalKey();
}

class AppSchoolEditKeys {
  static final inputName = GlobalKey();
  static final buttonGetLocation = GlobalKey();
  static final buttonAddImage = GlobalKey();
  static final buttonCancel = GlobalKey();
  static final buttonSave = GlobalKey();
}