import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';

Widget goalCard(
     String title, String total, String current,bool isAchived) {
  return Container(
      decoration: BoxDecoration(
          color: isAchived? AppColors.success : AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
          ),
          Text('$total / $current',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
        ],
      ));
}
