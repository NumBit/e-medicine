import 'package:firebase_analytics/firebase_analytics.dart';

class Global {
  // App Data
  static final String title = 'Fireship';

  // Services
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Helper Methods
  static doSomethingCool() => print('cool');
}