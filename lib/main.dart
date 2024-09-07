import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/services/notification_service.dart';

import 'base/base_bindings.dart';
import 'config/scroll_behavior_modified.dart';
import 'pages/splash_page.dart';
import 'theme/app_theme.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  await NotificationService.init();

//  handle in terminated state
  var initialNotification =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (initialNotification?.didNotificationLaunchApp == true) {
    // LocalNotifications.onClickNotification.stream.listen((event) {
    Future.delayed(Duration(seconds: 1), () {
      // push(TaskDetailPage(
      //     task: Task(
      //   title: 'sss',
      //   dueTime: DateTime.now(),
      // )));
      // print(event);
      // navigatorKey.currentState!.pushNamed('/another',
      //     arguments: initialNotification?.notificationResponse?.payload);
    });
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.get(isLight: true),
      darkTheme: AppTheme.get(isLight: false),
      title: 'TODO App',
      debugShowCheckedModeBanner: false,
      initialBinding: BaseBindings(),
      defaultTransition: Transition.cupertino,
      builder: (context, widget) {
        ScrollConfiguration(
          behavior: const ScrollBehaviorModified(),
          child: widget!,
        );
        final data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
            textScaler: TextScaler.linear(1.0),
          ),
          child: widget,
        );
      },
      home: SplashPage(),
    );
  }
}
