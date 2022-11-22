import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyZoomDrawerContoller extends GetxController {
  final zoomDrawerContoller = ZoomDrawerController();

  void onReady() {

    super.onReady();
  }
  
  void toogleDrawer() {
    zoomDrawerContoller.toggle?.call();

    update();
  }

  void signOut() {}

  void signIn() {}

  void website() {}

  void email() {
    final Uri emailLauchUri = Uri(
      scheme: 'mailto',
      path: 'adeyemijohndaniels@gmail.com',
    );
    _launch(emailLauchUri.toString());
  }

  Future<void> _launch(String url) async {
    if(!await launch(url)) {
      throw 'could not launch $url';
    }
  }
} 
