import 'package:flutter/material.dart';
import 'package:supermarket_inventory/Service/Notification.dart';
import 'package:supermarket_inventory/View/Notifaication/NotificationButton.dart';

class NotificationToggle extends StatelessWidget {
  const NotificationToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NotificationButton(
            text: "Notification",
            onPressed: () async {
              await NotificationService.showNotification(
                title: "Title of the notification",
                body: "Body of the notification",
              );
            },
          ),
        ],
      ),
    );
  }
}
