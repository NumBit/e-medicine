import 'package:flutter/widgets.dart';
import 'package:medicine_cabinet/cabinet/cabinet_model.dart';
import 'package:medicine_cabinet/drug/drug_model.dart';

class AppState extends ChangeNotifier {
  CabinetModel _cabinet =
      CabinetModel(id: "75KfFkAlO6ftGLpFJldV", name: "Lekarnicka");
  DrugModel _selectedDrug;
  String _filter = "";

  CabinetModel get cabinet => _cabinet;

  set cabinet(CabinetModel value) {
    _cabinet = value;
    notifyListeners();
  }

  DrugModel get selectedDrug => _selectedDrug;

  set selectedDrug(DrugModel model) {
    _selectedDrug = model;
    // notifyListeners();
  }

  String get filter => _filter;

  set filter(String filter) {
    _filter = filter;
    notifyListeners();
  }
}
