import 'package:flutter/widgets.dart';
import 'package:medicine_cabinet/drug/drug_model.dart';

class AppState extends ChangeNotifier {
  String _cabinetId = "75KfFkAlO6ftGLpFJldV";
  DrugModel _selectedDrug;

  String get cabinetId => _cabinetId;

  set cabinetId(String value) {
    _cabinetId = value;
    notifyListeners();
  }

  DrugModel get selectedDrug => _selectedDrug;

  set selectedDrug(DrugModel model) {
    _selectedDrug = model;
    notifyListeners();
  }
}
