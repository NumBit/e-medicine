import 'package:flutter/widgets.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';

class AppState extends ChangeNotifier {
  String _openCabinet;
  DrugModel _selectedDrug;
  String _filter = "";

  String get cabinet => _openCabinet;

  set cabinet(String value) {
    print("object" + value);
    _openCabinet = value;
    //notifyListeners();
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
