// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Future initializeNotifications(BuildContext context) async {
//   Future _selectNotification(String payload) async {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return new AlertDialog(
//           title: Text("PayLoad"),
//           content: Text("Payload : $payload"),
//         );
//       },
//     );
//   }

//   var initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   var initializationSettingsIOS = IOSInitializationSettings();
//   var initializationSettings = InitializationSettings(
//       initializationSettingsAndroid, initializationSettingsIOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: _selectNotification);
// }

// showNotification() async {
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your channel id', 'your channel name', 'your channel description',
//       importance: Importance.Max,
//       priority: Priority.High,
//       ongoing: true,
//       autoCancel: false);
//   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//   var platformChannelSpecifics = NotificationDetails(
//       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//       0, 'Goto WhatsApp number.', null, platformChannelSpecifics);
// }
