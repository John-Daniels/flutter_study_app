import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dialogs {
  static final Dialogs _singleton = Dialogs._internal();
  Dialogs._internal();

  factory Dialogs() {
    return _singleton;
  }

  static Widget questionStartDialogue({required VoidCallback onTap}) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Hi...',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Please login before you start'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onTap,
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  static Widget onLeaveDialog({
    required BuildContext context,
    String title = 'Are you sure you want to exit?',
    VoidCallback? onYes,
    required VoidCallback onNo,
  }) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(1),
      actionsPadding: EdgeInsets.zero,
      title: Text(title),
      actions: [
        TextButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(1),
          ),
          onPressed: onYes == null ? () => SystemNavigator.pop() : onYes,
          child: Text('yes'),
        ),
        TextButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(1),
          ),
          onPressed: onNo,
          child: Text('no'),
        ),
      ],
    );
  }
}
