import 'package:flutter/material.dart';
import 'package:jobscope/provider/button_state_provider.dart';
import 'package:jobscope/screens/home_screen_selector.dart/dash_screens/cards_dash/cards_dash.dart';
import 'package:jobscope/screens/home_screen_selector.dart/widgets/das_select_button.dart';
import 'package:jobscope/screens/home_screen_selector.dart/widgets/top_selector_buttons.dart';
import 'package:provider/provider.dart';

Widget homeScreenSelector(BuildContext context) {
  return Expanded(
    child: Column(
      children: [
        topSelectorButtons(context),
        SizedBox(height: 20,),
        if(context.read<ButtonsStateProvider>().isCardsSelected)
        // Text('test')
        Expanded(child: CardsDash())
      ],
    ),
  );
}
