import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/logger/app_logger.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/models/question_paper_model.dart';
import 'package:study_app/screens/questions/questions_screen.dart';
import 'package:study_app/services/firebase_storage_services.dart';

class QuestionPaperController extends GetxController {
  final allPapersImages = <String>[].obs;
  final allPapers = <QuestionPaperModel>[].obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = [
      "biology",
      "chemistry",
      "maths",
      "physics",
    ];

    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      // allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);

        paper.imageUrl = imgUrl!;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  void navigateToQuestions({
    required QuestionPaperModel paper,
    bool tryAgain = false,
  }) {
    AuthController authController = Get.find();
    if (authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
      } else {
        Get.toNamed(QuestionScreen.routeName, arguments: paper);
      }
    } else {
      authController.showLoginAlertDialog();
    }
  }
}
