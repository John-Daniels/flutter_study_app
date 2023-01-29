import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/controllers/questions/question_controller.dart';
import 'package:study_app/screens/questions/result_screen.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_app_bar.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/answer_card.dart';

class ReviewScreen extends GetView<QuestionController> {
  const ReviewScreen({super.key});
  static String routeName = '/review';

  get qTitle =>
      'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            qTitle,
            style: appBarTS,
          ),
        ),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Column(children: [
          Expanded(
            child: ContentArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text(controller.currentQuestion.value!.question),
                    GetBuilder<QuestionController>(
                      id: 'review',
                      builder: (_) {
                        return ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 25),
                          itemBuilder: (__, index) {
                            final answer =
                                _.currentQuestion.value!.answers[index];
                            final selectedAnswer =
                                _.currentQuestion.value!.selectedAnswer;
                            final correctAnswer =
                                _.currentQuestion.value!.correctAnswer;
                            final String answerText =
                                '${answer.identifier}. ${answer.answer}';

                            if (correctAnswer == selectedAnswer &&
                                answer.identifier == selectedAnswer) {
                              return CorrectAnswer(answer: answerText);
                            } else if (selectedAnswer == null &&
                                correctAnswer == answer.identifier) {
                              return CorrectAnswer(answer: answerText);
                            } else if (correctAnswer != selectedAnswer &&
                                    answer.identifier == selectedAnswer ||
                                selectedAnswer == null) {
                              return WrongAnswer(answer: answerText);
                            } else if (correctAnswer == answer.identifier)
                              return CorrectAnswer(answer: answerText);

                            return AnswerCard(
                              answer: answerText,
                              onTap: () {},
                              isSelected: false,
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount:
                              controller.currentQuestion.value!.answers.length,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
