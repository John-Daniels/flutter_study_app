import 'package:get/get.dart';
import 'package:study_app/controllers/questions/question_controller.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';
import 'package:study_app/controllers/questions/question_paper_controller.dart';
import 'package:study_app/screens/auth/login_screen.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/screens/onboarding/onboarding.dart';
import 'package:study_app/screens/questions/overview_screen.dart';
import 'package:study_app/screens/questions/questions_screen.dart';
import 'package:study_app/screens/questions/result_screen.dart';
import 'package:study_app/screens/questions/review_screen.dart';
import 'package:study_app/screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/onboarding',
          page: () => OnboardingScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: BindingsBuilder(
            () {
              Get.put(QuestionPaperController(), permanent: true);
              Get.put(MyZoomDrawerContoller(), permanent: true);
            },
          ),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),

        // questions
        GetPage(
          name: QuestionScreen.routeName,
          page: () => QuestionScreen(),
          binding: BindingsBuilder(() {
            Get.put<QuestionController>(QuestionController());
          }),
        ),

        GetPage(
          name: OverviewScreen.routeName,
          page: () => OverviewScreen(),
        ),

        GetPage(
          name: ResultScreen.routeName,
          page: () => ResultScreen(),
        ),
        GetPage(name: ReviewScreen.routeName, page: () => ReviewScreen())
      ];
}
