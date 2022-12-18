import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.title = '',
    required this.onTap,
    this.enabled,
    this.child,
    this.color,
  });

  final String title;
  final VoidCallback onTap;
  final enabled;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: 55,
        child: InkWell(
          onTap: enabled == false ? null : onTap,
          borderRadius: BorderRadius.circular(15),
          child: Ink(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color ?? Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: child ??
                  Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? onSurfaceTextColor
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
