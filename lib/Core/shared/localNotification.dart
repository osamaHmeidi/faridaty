import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
 static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
 static onTap(NotificationResponse n){}
 static Future init()async{
  InitializationSettings  setting = const  InitializationSettings(android:AndroidInitializationSettings("@mipmap/ic_launcher"));
await  flutterLocalNotificationsPlugin.initialize(setting,onDidReceiveBackgroundNotificationResponse: onTap,onDidReceiveNotificationResponse: onTap); 
}

 static Future showNotification(String title, String body)async{
  
  NotificationDetails notificationDetails = NotificationDetails(android: AndroidNotificationDetails("channelId", "channelName",importance: Importance.max,priority: Priority.high,sound: RawResourceAndroidNotificationSound('notification_adan')));
  await flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
 }

}