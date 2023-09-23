// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:testnotification/local_notification_service.dart';
import 'package:testnotification/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    listenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Flutter Notification Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Push Notification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Click the button to push a notification. Click on the notification received/popped to navigate to the next page.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 16),

            const Icon(
              Icons.arrow_downward,
              size: 36,
            ),
            const SizedBox(height: 16),

            Container(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  await service.showNotificationWithPayload(
                    id: 0,
                    title: 'Flutter Notification Demo',
                    body: 'Click on this notification to go to the next page.',
                    payload: 'payload navigation',
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  onPrimary: Colors.white,
                ),
                child: const Text(
                  'Push Notification Now!',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNotificationListener);

  void onNotificationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      Navigator.push(
        context,
        MaterialPageRoute(builder: ((context) => SecondPage(payload: payload))),
      );
    }
  }
}
