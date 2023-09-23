import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
    Key? key,
    required this.payload,
    }) : super(key: key);

    final String payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Notification Clicked!'),
      ),
      body: const Center(
        child: Text(
          "Voila! You've reached the next page of this app successfully.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
