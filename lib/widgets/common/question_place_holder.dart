import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class QuestionScreenHolder extends StatelessWidget {
  const QuestionScreenHolder({super.key});

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

    var answer = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 50.0,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );

    return Shimmer.fromColors(
      child: EasySeparatedColumn(
        separatorBuilder: (context, index) {
          return SizedBox(height: 20);
        },
        children: [
          EasySeparatedColumn(
            children: [line, line, line, line],
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
          ),
          answer,
          answer,
          answer,
        ],
      ),
      baseColor: Colors.white,
      highlightColor: Colors.blueGrey.withOpacity(0.5),
    );
  }
}
