import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/provider/button_state_provider.dart';
import 'package:jobscope/provider/self_applied_companies_provider.dart';
import 'package:provider/provider.dart';

Widget refreshButton(BuildContext context) {
  return MouseRegion(
    onEnter: (_) => context.read<ButtonsStateProvider>().refreshButtonHovered(),
    onExit: (_) => context.read<ButtonsStateProvider>().refreshButtonHovered(),
    child: IconButton(
        style: IconButton.styleFrom(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            padding: EdgeInsets.zero),
        padding: const EdgeInsets.all(0),
        hoverColor: AppColors.secondaryColor,
        highlightColor: AppColors.secondaryColor,
        iconSize: 20,
        onPressed: () {
          context.read<SelfAppliedCompaniesProvider>().fechDataFromSheet();
        },
        icon: Icon(
          Icons.refresh,
          color: context.watch<ButtonsStateProvider>().isRefreshButtonHovered
              ? AppColors.primaryColor
              : AppColors.secondaryColor,
        )),
  );
}
