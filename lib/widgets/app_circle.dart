import 'package:flutter/material.dart';

class AppCircleButton extends StatelessWidget {
  const AppCircleButton({
    super.key,
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.none,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        overlayColor: MaterialStatePropertyAll(
          Theme.of(context).primaryColor.withOpacity(0.1),
        ),
        child: Ink(
          padding: EdgeInsets.all(5),
          child: child,
        ),
      ),
    );
  }
}
