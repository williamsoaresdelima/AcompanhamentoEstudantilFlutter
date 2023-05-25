import 'School.dart';
import 'Supplies.dart';

class ScreenArguments {

  School singleSchool = School("0", "", [], [], "");
  Supplies supplie = Supplies(0, "", "", 0.00, "", 0);

    ScreenArguments(
    this.singleSchool,
    this.supplie
    );
}