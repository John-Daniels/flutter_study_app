import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_icons.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/screens/questions/overview_screen.dart';
import 'package:study_app/widgets/app_circle.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.titleWidget,
    this.onMenuActionTap,
    this.showActionIcon = false,
    this.leading,
  });

  final String title;
  final Widget? leading;
  final Widget? titleWidget;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mobileScreenPadding,
          vertical: mobileScreenPadding,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: titleWidget == null
                    ? Text(
                        title,
                        style: appBarTS,
                      )
                    : titleWidget,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading ??
                    Transform.translate(
                      offset: Offset(-14, 0),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          CupertinoIcons.back,
                          size: 20,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                if (showActionIcon)
                  Transform.translate(
                    offset: Offset(4, 0),
                    child: AppCircleButton(
                      child: Icon(AppIcons.menu),
                      onTap: onMenuActionTap ??
                          () => Get.toNamed(OverviewScreen.routeName),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 80);
}
