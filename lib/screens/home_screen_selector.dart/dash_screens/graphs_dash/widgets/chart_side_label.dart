import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';

Widget chartSideLabel({required String title,required Color color}) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50)),
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        title,
        style: TextStyle(color: AppColors.secondaryColor),
      ),
    ],
  );
}
