import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/widgets/refresh_button.dart';

Widget topBar(BuildContext context) {
  return WindowTitleBarBox(
      child: Row(
    children: [
      Expanded(child: MoveWindow()),
      refreshButton(context),
      MinimizeWindowButton(
        colors: WindowButtonColors(mouseOver: AppColors.secondaryColor),
      ),
      MaximizeWindowButton(
        colors: WindowButtonColors(mouseOver: AppColors.secondaryColor),
      ),
      CloseWindowButton()
    ],
  ));
}
