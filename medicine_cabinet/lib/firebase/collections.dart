import 'package:firebase_analytics/firebase_analytics.dart';

class Collections {
  // Collection names
  static final String drugsCollection = "drugs";
  static final String cabinetsCollection = "cabinets";
  static final String categoriesCollection = "categories";

  // Services
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Helper Methods
  static doSomethingCool() => print('cool');
}
