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
                          itemBuilder: (_, index) {
                            final answer = controller
                                .currentQuestion.value!.answers[index];
                            final selectedAnswer = controller
                                .currentQuestion.value!.selectedAnswer;
                            final correctAnswer =
                                controller.currentQuestion.value!.correctAnswer;
                            final String answerText =
                                '${answer.identifier}. ${answer.answer}';

                            if (correctAnswer == selectedAnswer &&
                                answer.identifier == selectedAnswer) {
                              return CorrectAnswer(answer: answerText);
                            } else if (selectedAnswer == null) {
                              return NotAnswered(answer: answerText);
                            } else if (correctAnswer != selectedAnswer &&
                                answer.identifier == selectedAnswer) {
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
