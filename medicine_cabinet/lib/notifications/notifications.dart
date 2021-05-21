import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';

void createNotification(int id, String body, DateTime date) async {
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
        enableVibration: true,
        category: "reminder",
        channelShowBadge: true,
        importance: Importance.max,
      )),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}
