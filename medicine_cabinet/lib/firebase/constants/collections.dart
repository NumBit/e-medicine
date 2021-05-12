import 'package:firebase_analytics/firebase_analytics.dart';

class Collections {
  // Collection names

  static final String cabinets = "cabinets";
  static final String drugs = "drugs";
  static final String packages = "packages";
  static final String categories = "categories";
  static final String users = "users";
  static final String userCabinet = "user_cabinet";
  static final String owners = "owners";
  static final String schedules = "schedules";

  // Services
  // TODO
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Helper Methods
  // TODO
  static doSomethingCool() => print('cool');
}
