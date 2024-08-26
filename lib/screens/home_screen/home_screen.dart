import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/screens/home_screen_selector.dart/home_screen_selector.dart';
import 'package:jobscope/services/googe_sheet.dart';
import 'package:jobscope/widgets/refresh_button.dart';
import 'package:jobscope/widgets/top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WindowBorder(
          color: AppColors.secondaryColor,
          child: Column(
            children: [
              topBar(context),
              homeScreenSelector(context)
            ],
          ),
        ));
  }
}
