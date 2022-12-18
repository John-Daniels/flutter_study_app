import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/controllers/questions/question_controller.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/models/question_paper_model.dart';

extension QuestionsControllerExtension on QuestionController {
  List<Questions> get correctQuestions =>
      allQuestions.where((q) => q.selectedAnswer == q.correctAnswer).toList();

  int get correctQuestionsCount => correctQuestions.length;
  String get correctAnsweredQuestions {
    return '$correctQuestionsCount out of ${allQuestions.length} are correct';
  }

  String get points {
    var points = (correctQuestionsCount / allQuestions.length) *
        100 *
        (questionPaperModel.timeSeconds - remainSeconds) /
        questionPaperModel.timeSeconds *
        100;

    return points.toStringAsFixed(2);
  }

  Future saveTestResults() async {
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) return;
    batch.set(
        userRF
            .doc(_user.email)
            .collection('recent_tests')
            .doc(questionPaperModel.id),
        {
          "points": points,
          "correct_answer": '$correctQuestionsCount / ${allQuestions.length}',
          "questions_id": questionPaperModel.id,
          'time': questionPaperModel.timeSeconds - remainSeconds
        });

    batch.commit();
    navigateToHome();
  }
}
