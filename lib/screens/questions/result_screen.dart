import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_dark_theme.dart';
import 'package:study_app/configs/themes/app_light_theme.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/questions/question_controller.dart';
import 'package:study_app/controllers/questions/question_controller_extention.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/screens/questions/review_screen.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_app_bar.dart';
import 'package:study_app/widgets/common/main_button.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/dialogs/dialog_widget.dart';
import 'package:study_app/widgets/questions/answer_card.dart';
import 'package:study_app/widgets/questions/question_number_card.dart';

class ResultScreen extends GetView<QuestionController> {
  const ResultScreen({super.key});

  static const String routeName = '/results';

  @override
  Widget build(BuildContext context) {
    Color _textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;

    return WillPopScope(
      onWillPop: () async {
        if (await _showDialog(context)) Get.offAllNamed(HomeScreen.routeName);

        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          leading: SizedBox(height: 80),
          title: controller.correctAnsweredQuestions,
        ),
        body: BackgroundDecoration(
          child: Column(
            children: [
              Expanded(
                child: ContentArea(
                  addPadding: false,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: mobileScreenPadding),
                    children: [
                      SizedBox(height: mobileScreenPadding),
                      SvgPicture.asset('assets/images/bulb.svg'),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 5,
                        ),
                        child: Text(
                          'Congratulations',
                          style: headerText.copyWith(color: _textColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'You have ${controller.points} points',
                        style: TextStyle(color: _textColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                      const Text(
                        'Tap below question numbers to view correct answers',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                      GridView.builder(
                        itemCount: controller.allQuestions.length,
                        shrinkWrap: true,
                        padding:
                            EdgeInsets.only(bottom: mobileScreenPadding + 10),
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.width ~/ 75,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        itemBuilder: (_, index) {
                          final _question = controller.allQuestions[index];

                          AnswerStatus _status = AnswerStatus.notanswered;
                          final _selectedAnswer = _question.selectedAnswer;
                          final _correctAnswer = _question.correctAnswer;
                          if (_selectedAnswer == _correctAnswer)
                            _status = AnswerStatus.correct;
                          else if (_selectedAnswer == null)
                            _status = AnswerStatus.wrong;
                          else
                            _status = AnswerStatus.wrong;

                          return QuestionNumberCard(
                            index: index + 1,
                            status: _status,
                            onTap: () {
                              controller.jumpToQuestion(index, isGoBack: false);
                              Get.toNamed(ReviewScreen.routeName);
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: MainButton(
                          onTap: controller.tryAgain,
                          color: primaryColorLight.withOpacity(0.4),
                          title: 'Try again',
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: MainButton(
                          onTap: controller.saveTestResults,
                          color: primaryColorDark.withOpacity(0.4),
                          title: 'Go home',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialogs.onLeaveDialog(
          context: context,
          title: 'Wanna Leave',
          onNo: () {
            Navigator.pop(context);
          },
          onYes: () {
            Navigator.pop(context, true);
          },
        );
      },
    );
  }
}
