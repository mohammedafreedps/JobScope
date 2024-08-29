import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';

Widget dashSelectButton({required String label,required bool isSelected,Function? function}){
  return InkWell(
    onTap: (){
      if(function != null && !isSelected){
        function();
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal:  15,vertical: 5),
      decoration: BoxDecoration(color: isSelected ? AppColors.secondaryColor : AppColors.primaryColor,borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text(label,style: TextStyle(color: isSelected ? AppColors.primaryColor: AppColors.secondaryColor),)),
    ),
  );
}