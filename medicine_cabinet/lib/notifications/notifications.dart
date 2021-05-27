import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';

Future<void> createNotification(int id, String body, DateTime date) async {
  if (DateTime.now().isAfter(date)) return;
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "Time to take your medication",
      body,
      tz.TZDateTime.from(date, tz.local),
      const NotificationDetails(
          android: AndroidNotificationDetails(
        "medication",
        "Medicine cabinet",
        "Notifications for medications reminders",
        enableLights: true,
        category: "reminder",
        importance: Importance.max,
      )),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}

Future<void> cancelNotification(int id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}
