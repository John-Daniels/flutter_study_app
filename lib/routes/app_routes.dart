import 'package:get/get.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';
import 'package:study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:study_app/screens/auth/login_screen.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/screens/onboarding/onboarding.dart';
import 'package:study_app/screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/onboarding',
          page: () => const OnboardingScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: BindingsBuilder(
            () {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerContoller());
            },
          ),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
      ];
}
