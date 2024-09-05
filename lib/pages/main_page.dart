import 'package:flutter/material.dart';
import 'package:todo_app/component/left_drawer.dart';
import 'package:todo_app/pages/task_list_page.dart';
import 'package:todo_app/services/notification_service.dart';
import '../base/base.dart';
import '../helpers/k_text.dart';
import '../helpers/route.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Base.connectivityService; // Initialize connectivity service
  }

  @override
  Widget build(BuildContext context) {
    // final platform = Theme.of(context).platform;
    return Scaffold(
      drawer: LeftDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
        title: KText(
          text: 'TODO App',
          color: Colors.white,
          bold: true,
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextButton(
                  onPressed: () {
                    push(TaskListPage());
                  },
                  child: KText(text: 'Image Picker')),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.notifications_outlined),
              onPressed: () {
                //  LocalNotifications.showScheduleNotification(
                //       title: "Schedule Notification",
                //       body: "This is a Schedule Notification",
                //       payload: "This is schedule data");
                NotificationService.showSimpleNotification(
                    title: 'Simple Notification',
                    body: 'This is a simple notification',
                    payload: 'This is simple data');
              },
              label: Text('Simple Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
