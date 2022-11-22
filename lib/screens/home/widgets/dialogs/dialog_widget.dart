import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static final Dialogs _singleton = Dialogs._internal();
  Dialogs._internal();

  factory Dialogs() {
    return _singleton;
  }

  Widget questionStartDialogue({required VoidCallback onTap}) {
    return AlertDialog(
      content: Column(
        children: const [],
      ),
    );
  }
}
