import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/app_icons.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';
import 'package:study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:study_app/screens/home/components/menu_drawer.dart';
import 'package:study_app/screens/home/components/question_card.dart';
import 'package:study_app/screens/home/components/question_skeleton.dart';
import 'package:study_app/widgets/app_circle.dart';
import 'package:study_app/widgets/content_area.dart';

class HomeScreen extends GetView<MyZoomDrawerContoller> {
  const HomeScreen({super.key});

  static final routeName = 'home';

  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController =
        Get.find<QuestionPaperController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<MyZoomDrawerContoller>(builder: (_) {
        return Container(
          decoration: BoxDecoration(gradient: mainGradient()),
          child: ZoomDrawer(
            // showShadow: true,
            borderRadius: 40,
            angle: 0,
            style: DrawerStyle.defaultStyle,
            // menuBackgroundColor: Colors.white.withOpacity(0.5),
            menuScreenWidth: double.maxFinite,
            slideWidth: MediaQuery.of(context).size.width * 0.4,
            controller: controller.zoomDrawerContoller,
            menuScreen: const MenuDrawer(),
            mainScreen: Container(
              decoration: BoxDecoration(gradient: mainGradient()),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppCircleButton(
                            onTap: controller.toogleDrawer,
                            child: const Icon(
                              AppIcons.menuLeft,
                              color: onSurfaceTextColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Icon(
                                  AppIcons.peace,
                                  color: onSurfaceTextColor,
                                ),
                                Text(
                                  'Hello Friend',
                                  style: detailText.copyWith(
                                      color: onSurfaceTextColor),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'What do you want to learn today?',
                            style: headerText,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(
                            () {
                              if (questionPaperController.allPapers.isEmpty)
                                return ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding: UIParameters.mobileScreenPadding,
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 20),
                                  itemBuilder: (context, index) {
                                    return QuestionCardSkeleton();
                                  },
                                );
                              else
                                return ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding: UIParameters.mobileScreenPadding,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return QuestionCard(
                                      model: questionPaperController
                                          .allPapers[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 20),
                                  itemCount:
                                      questionPaperController.allPapers.length,
                                );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
