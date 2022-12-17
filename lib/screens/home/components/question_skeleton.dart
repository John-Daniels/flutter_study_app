import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class QuestionCardSkeleton extends StatelessWidget {
  const QuestionCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    var line = ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Container(
        width: double.infinity,
        height: 12.0,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );

    var Skeleton = (
            {required double height,
            required double width,
            double borderRadius = 3}) =>
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            width: width,
            height: height,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        );

    return Shimmer.fromColors(
      child: Container(
        height: 120,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(
                  height: 60,
                  width: 60,
                  borderRadius: 10,
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: EasySeparatedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 80, child: line),
                      SizedBox(height: 1),
                      line,
                      line,
                      line,
                    ],
                    separatorBuilder: (context, _) => SizedBox(
                      height: 8,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: Get.width * 0.5,
                  child: Row(
                    children: [
                      ...[1, 2, 3].map(
                        (e) => Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: line,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      baseColor: Colors.white,
      highlightColor: Colors.blueGrey.withOpacity(0.5),
    );
  }
}
