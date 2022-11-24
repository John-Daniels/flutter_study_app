import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MyZoomDrawerContoller extends GetxController {
  final zoomDrawerContoller = ZoomDrawerController();
  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toogleDrawer() {
    zoomDrawerContoller.toggle?.call();

    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {}

  void website() {
    // _launch(Uri(path: 'https://johnkoder.vercel.app',));
    launchUrlString('https://johnkoder.vercel.app');
  }

  void email() {
    final Uri emailLauchUri = Uri(
      scheme: 'mailto',
      path: 'adeyemijohndaniels@gmail.com',
    );
    _launch(emailLauchUri);
  }

  Future<void> _launch(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'could not launch $url';
    }
  }
}
