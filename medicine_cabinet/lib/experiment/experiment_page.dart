import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';

class ExperimentPage extends StatelessWidget {
  const ExperimentPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //CabinetRepository(context).add(CabinetModel(name: "Special Cab"));
          //UserRepository(context).add(UserModel())
        },
        label: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              } else {
                return ElevatedButton(
                  onPressed: () {
                    //UserRepository(context)
                    //.add(UserModel(cabinets: ["abc", "def"]));
                  },
                  child: const Text("Add user"),
                );
              }
            },
          ),
          ElevatedButton(
              onPressed: () async {
                const AndroidNotificationDetails
                    androidPlatformChannelSpecifics =
                    AndroidNotificationDetails('your channel id',
                        'Medicine Cabinet', 'your channel description',
                        importance: Importance.low, priority: Priority.high);
                const NotificationDetails platformChannelSpecifics =
                    NotificationDetails(
                        android: androidPlatformChannelSpecifics);
                await flutterLocalNotificationsPlugin.show(
                    0, 'plain title', 'plain body', platformChannelSpecifics,
                    payload: 'item x');
              },
              child: const Text("Notify")),
          ElevatedButton(
              onPressed: () async {
                await flutterLocalNotificationsPlugin.zonedSchedule(
                    0,
                    'scheduled title',
                    'scheduled body',
                    tz.TZDateTime.now(tz.local)
                        .add(const Duration(seconds: 10)),
                    const NotificationDetails(
                        android: AndroidNotificationDetails('your channel id',
                            'your channel name', 'your channel description')),
                    androidAllowWhileIdle: true,
                    uiLocalNotificationDateInterpretation:
                        UILocalNotificationDateInterpretation.absoluteTime);
              },
              child: const Text("Notify timed"))
        ],
      ),
    );
  }
}
