import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/helpers/k_log.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

// on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

// initialize the local notifications
  static Future init() async {
    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            // iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    // request notification permissions
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            sound: RawResourceAndroidNotificationSound('notification'),
            playSound: true,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  // // to show periodic notification at regular interval
  // static Future showPeriodicNotifications({
  //   required String title,
  //   required String body,
  //   required String payload,
  // }) async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('channel 2', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await _flutterLocalNotificationsPlugin.periodicallyShow(
  //       1, title, body, RepeatInterval.everyMinute, notificationDetails,
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       payload: payload);
  // }

  // to schedule a local notification
  static Future showScheduleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones();
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'channel 3', 'your channel name',
                channelDescription: 'your channel description',
                importance: Importance.max,
                priority: Priority.high,
                sound:
                    RawResourceAndroidNotificationSound('notification_sound'),
                playSound: true,
                ticker: 'ticker')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);

    // // iOS notification details
    // var iOSDetails = DarwinNotificationDetails(
    //   sound: 'notification_sound.aiff',
    // );
    // // android notification details
    // var androidDetails = DarwinNotificationDetails(
    //   sound: 'notification_sound.aiff',
    // );

    // // Notification details for both platforms
    // var notificationDetails = NotificationDetails(
    //   android: androidDetails,
    //   iOS: iOSDetails,
    // );

    kLog('value');
  }

  // // close a specific channel notification
  // static Future cancel(int id) async {
  //   await _flutterLocalNotificationsPlugin.cancel(id);
  // }

  // close all the notifications available
  static Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  // Future<void> scheduleDailyNotification(DateTime selectedTime) async {
  //   if (selectedTime.isBefore(DateTime.now())) {
  //     selectedTime = selectedTime.add(const Duration(days: 1));
  //   }
  //   final tz.TZDateTime scheduledTime =
  //       tz.TZDateTime.from(selectedTime, tz.local);

  //   try {
  //     await _flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       "notification title",
  //       "notification body",
  //       scheduledTime,
  //       _notificationDetails(),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.time,
  //     );

  //     kLog('Notification scheduled successfully');
  //   } catch (e) {
  //     kLog('Error scheduling notification: $e');
  //   }
  // }

  // NotificationDetails _notificationDetails() {
  //   return NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'your_channel_id',
  //       'your_channel_name',
  //       // 'your_channel_description',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       showWhen: false,
  //     ),
  //     // iOS: IOSNotificationDetails(),
  //   );
  // }
}
