import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/widgets/app_circle.dart';

class OnboardingScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 65,
              ),
              const SizedBox(height: 40),
              const Text(
                'Welcome to the ultimate study app, where you can improve your knowledge in physics, chemistry, math, and biology with ease. With a comprehensive database of questions and answers, instant feedback, and progress tracking, you\'ll be able to master these subjects in no time',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: onSurfaceTextColor,
                ),
              ),
              const SizedBox(height: 40),
              AppCircleButton(
                onTap: () => controller.navigateToHomePage(),
                child: const Icon(
                  size: 35,
                  Icons.arrow_forward,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
