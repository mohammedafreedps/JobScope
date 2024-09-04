import 'package:flutter/material.dart';

class ButtonsStateProvider extends ChangeNotifier {
  bool isRefreshButtonHovered = false;

  bool isCardsSelected = true;
  bool isGraphsSelected = false;
  bool isGoalSelected = false;

  bool isLoading = true;

  void refreshButtonHovered() {
    isRefreshButtonHovered = !isRefreshButtonHovered;
    notifyListeners();
  }



  void cardsButtonClicked() {
    if (!isCardsSelected) {
      isGraphsSelected = false;
      isGoalSelected = false;
    }
    isCardsSelected = !isCardsSelected;
    notifyListeners();
  }

  void graphButtonClicked() {
    if (!isGraphsSelected) {
      isCardsSelected = false;
      isGoalSelected = false;
    }
    isGraphsSelected = !isGraphsSelected;
    notifyListeners();
  }

  void goalButtonClicked() {
    if (!isGoalSelected) {
      isCardsSelected = false;
      isGraphsSelected = false;
    }
    isGoalSelected = !isGoalSelected;
    notifyListeners();
  }

}
