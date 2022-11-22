import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/custom_text_styles.dart';
import 'package:study_app/configs/themes/app_icons.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/models/question_paper_model.dart';
import 'package:study_app/widgets/app_icon_text.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.model});

  final QuestionPaperModel model;

  @override
  Widget build(BuildContext context) {
    const double padding = 10.0;
    var detailColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColoredBox(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    child: SizedBox(
                      height: Get.width * 0.15,
                      width: Get.width * 0.15,
                      child: CachedNetworkImage(
                        imageUrl: model.imageUrl,
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/app_splash_logo.png',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: cartTitles(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 15,
                        ),
                        child: Text(model.description),
                      ),
                      Row(
                        children: [
                          AppIconText(
                            icon: Icon(
                              Icons.help_outline_sharp,
                              color: detailColor,
                            ),
                            text: Text(
                              '${model.questionCount} questions',
                              style: detailText.copyWith(
                                color: detailColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          AppIconText(
                            icon: Icon(
                              Icons.timer,
                              color: detailColor,
                            ),
                            text: Text(
                              model.timeInMinites(),
                              style: detailText.copyWith(
                                color: detailColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: -padding,
              right: -padding,
              child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(cardBorderRadius),
                      bottomRight: Radius.circular(cardBorderRadius),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Icon(
                    AppIcons.trophyOutLine,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
