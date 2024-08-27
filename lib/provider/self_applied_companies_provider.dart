import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobscope/constants/graph_dash_values.dart';
import 'package:jobscope/models/self_applied_companies_model.dart';
import 'package:jobscope/services/googe_sheet.dart';

class SelfAppliedCompaniesProvider extends ChangeNotifier {
  bool isCardDataLoading = true;
  List<SelfAppliedCompaniesModel> selfAppliedCompaniesList = [];
  List<SelfAppliedCompaniesModel> _selfAppliedCompaniesList = [];
  Timer? _debounce;

  int totalAppliedCompany = 0;

  List<int> statusCounts = [];

  List<double> pieChartPercentage = [];

  void fechDataFromSheet() async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        isCardDataLoading = true;
        notifyListeners();

        _selfAppliedCompaniesList = await GoogleSheet.getAll();
        selfAppliedCompaniesList = _selfAppliedCompaniesList;

        isCardDataLoading = false;
        notifyListeners();
      } catch (e) {
        isCardDataLoading = false;
        notifyListeners();
      }
    });
  }

  void searchByTitle(String query) {
    if (query.isEmpty) {
      selfAppliedCompaniesList = _selfAppliedCompaniesList;
      notifyListeners();
    } else {
      selfAppliedCompaniesList = _selfAppliedCompaniesList
          .where((item) =>
              item.companyName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

  void setShowRemark(int index) {
    selfAppliedCompaniesList[index].showRemark =
        !selfAppliedCompaniesList[index].showRemark;
    notifyListeners();
  }

void setUpGraphData() {
  statusCounts = []; 
  totalAppliedCompany = _selfAppliedCompaniesList.length;
  pieChartPercentage = [];

  for (var i = 0; i < status.length; i++) {
    List matchingItems = _selfAppliedCompaniesList
        .where((item) => item.currentStatus.trim().toLowerCase() == status[i].trim().toLowerCase())
        .toList();
    
    statusCounts.add(matchingItems.length);
  }
  for (var i = 0; i < statusCounts.length; i++) {
    double holdValue = (statusCounts[i] / totalAppliedCompany) * 100;
    pieChartPercentage.add(holdValue);
  }
  notifyListeners();
}
}
