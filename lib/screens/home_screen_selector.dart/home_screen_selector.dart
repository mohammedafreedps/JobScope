import 'package:flutter/material.dart';
import 'package:jobscope/provider/button_state_provider.dart';
import 'package:jobscope/screens/home_screen_selector.dart/dash_screens/cards_dash/cards_dash.dart';
import 'package:jobscope/screens/home_screen_selector.dart/widgets/top_selector_buttons.dart';
import 'package:provider/provider.dart';

Widget homeScreenSelector(BuildContext context) {
  return Expanded(
    child: Column(
      children: [
        topSelectorButtons(context),
        if(context.read<ButtonsStateProvider>().isCardsSelected)
        Expanded(child: CardsDash())
      ],
    ),
  );
}
