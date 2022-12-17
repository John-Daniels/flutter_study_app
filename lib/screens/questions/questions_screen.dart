import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/controllers/question_paper/question_controller.dart';
import 'package:study_app/firebase_ref/loading_status.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/main_button.dart';
import 'package:study_app/widgets/common/question_place_holder.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/answer_card.dart';

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({super.key});

  static final routeName = '/question';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        child: BackgroundDecoration(
          child: Obx(
            () => ContentArea(
              child: Column(
                children: [
                  if (controller.loadingStatus.value == LoadingStatus.loading)
                    Expanded(child: QuestionScreenHolder()),

                  // questions & answers
                  if (controller.loadingStatus.value == LoadingStatus.completed)
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              controller.currentQuestion.value!.question,
                              style: questionTS,
                            ),
                            GetBuilder<QuestionController>(
                                id: 'answers_list',
                                builder: (controller) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 25),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final answer = controller.currentQuestion
                                          .value!.answers[index];

                                      return AnswerCard(
                                        isSelected: answer.identifier ==
                                            controller.currentQuestion.value!
                                                .selectedAnswer,
                                        answer:
                                            '${answer.identifier}. ${answer.answer}',
                                        onTap: () {
                                          controller.selectedAnswer(
                                              answer.identifier);
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 10,
                                    ),
                                    itemCount: controller
                                        .currentQuestion.value!.answers.length,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  // actions
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Row(
                      children: [
                        Visibility(
                          // visible: controller.isFirstQuestion,
                          child: SizedBox(
                            width: 55,
                            height: 55,
                            child: MainButton(
                              onTap: () {},
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Get.isDarkMode
                                    ? onSurfaceTextColor
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          child: MainButton(
                            onTap: () {
                              
                            },
                            title: 'Next',
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
