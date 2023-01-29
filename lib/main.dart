import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_app/bindings/initial_bindings.dart';
import 'package:study_app/controllers/theme_controller.dart';
import 'package:study_app/firebase_options.dart';
import 'package:study_app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(OrientationBuilder(builder: (context, orientation) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MyApp();
  }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Get.find<ThemeController>().lightTheme,
      getPages: AppRoutes.routes(),
    );
  }
}

// void main() async {
// WidgetsFlutterBinding.ensureInitialized();

//   runApp(
//     GetMaterialApp(
//       home: DataUploaderScreen(),
//     ),
//   );
// }
