import 'package:flutter/material.dart';

class ButtonsStateProvider extends ChangeNotifier {
  bool isRefreshButtonHovered = false;

  bool isCardsSelected = true;
  bool isGraphsSelected = false;

  void refreshButtonHovered(){
    isRefreshButtonHovered = !isRefreshButtonHovered;
    notifyListeners();
  }

  void cardsButtonClicked(){
    isGraphsSelected = !isGraphsSelected;
    isCardsSelected = !isCardsSelected;
    notifyListeners();
  }
  void graphButtonClicked(){
    isCardsSelected = !isCardsSelected;
    isGraphsSelected = !isGraphsSelected;
    notifyListeners();
  }
}