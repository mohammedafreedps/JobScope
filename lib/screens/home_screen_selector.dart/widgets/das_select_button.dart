import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';

Widget dashSelectButton(
    {required String label, required bool isSelected, Function? function, bool isGoalAchived = false}) {
  return InkWell(
    onTap: () {
      if (function != null && !isSelected) {
        function();
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryColor
              : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Center(
              child: Text(
            label,
            style: TextStyle(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.secondaryColor),
          )),
          isGoalAchived ? const SizedBox(width: 5,) : Container(),
          isGoalAchived ? Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(90),color: AppColors.success,),) : Container()
        ],
      ),
    ),
  );
}
