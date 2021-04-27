import 'package:firebase_analytics/firebase_analytics.dart';

class Collections {
  // Collection names
  static final String drugs = "drugs";
  static final String cabinets = "cabinets";
  static final String categories = "categories";
  static final String users = "users";
  static final String owners = "owners";

  // Services
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Helper Methods
  static doSomethingCool() => print('cool');
}
