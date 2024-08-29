import 'package:flutter/material.dart';
import 'package:jobscope/provider/button_state_provider.dart';
import 'package:jobscope/provider/self_applied_companies_provider.dart';
import 'package:jobscope/screens/home_screen_selector.dart/widgets/das_select_button.dart';
import 'package:provider/provider.dart';

Widget topSelectorButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      dashSelectButton(
          label: 'Cards',
          isSelected: context.watch<ButtonsStateProvider>().isCardsSelected,
          function: () {
            context.read<ButtonsStateProvider>().cardsButtonClicked();
          }),
      const SizedBox(
        width: 10,
      ),
      dashSelectButton(
          label: 'Graphs',
          isSelected: context.watch<ButtonsStateProvider>().isGraphsSelected,
          function: () {
            context.read<ButtonsStateProvider>().graphButtonClicked();
          }),
      const SizedBox(
        width: 10,
      ),
      dashSelectButton(
        isGoalAchived: context.watch<SelfAppliedCompaniesProvider>().isGoalAchived,
          label: 'Goal',
          isSelected: context.watch<ButtonsStateProvider>().isGoalSelected,
          function: () {
            context.read<ButtonsStateProvider>().goalButtonClicked();
          }),
    ],
  );
}
