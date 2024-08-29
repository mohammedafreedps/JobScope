import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobscope/constants/graph_dash_values.dart';
import 'package:jobscope/models/self_applied_companies_model.dart';
import 'package:jobscope/services/date_time_to_google_sheet_serial_number.dart';
import 'package:jobscope/services/googe_sheet.dart';

class SelfAppliedCompaniesProvider extends ChangeNotifier {
  bool isCardDataLoading = true;
  bool doHaveTodayData = false;
  bool doHaveGrandData = false;
  List<SelfAppliedCompaniesModel> selfAppliedCompaniesList = [];
  List<SelfAppliedCompaniesModel> _selfAppliedCompaniesList = [];
  List<SelfAppliedCompaniesModel> _todayAppliedCompaniesList = [];
  Timer? _debounce;

  int totalAppliedCompany = 0;

  int todayTotalAppliedCompany = 0;

  List<int> statusCounts = [];

  List<int> todayStatusCounts = [];

  List<double> pieChartPercentage = [];

  List<double> todayPieChartPercentage = [];

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

  void setUpGrandGraphData() {
    statusCounts = [];
    totalAppliedCompany = _selfAppliedCompaniesList.length;
    pieChartPercentage = [];

    if (totalAppliedCompany == 0) {
      doHaveGrandData = false;
      notifyListeners();
    } else {
      doHaveGrandData = true;
      for (var i = 0; i < status.length; i++) {
        List matchingItems = _selfAppliedCompaniesList
            .where((item) =>
                item.currentStatus.trim().toLowerCase() ==
                status[i].trim().toLowerCase())
            .toList();

        statusCounts.add(matchingItems.length);
      }
      for (var i = 0; i < statusCounts.length; i++) {
        double holdValue = (statusCounts[i] / totalAppliedCompany) * 100;
        pieChartPercentage.add(holdValue);
      }
      setUpTodayGraphData();
      notifyListeners();
    }
  }

  void setUpTodayGraphData() {
    todayStatusCounts = [];
    _todayAppliedCompaniesList = _selfAppliedCompaniesList
        .where((item) =>
            item.date ==
            dateTimeToGoogleSheetsSerialNumber(DateTime.now()).toString())
        .toList();
    todayTotalAppliedCompany = _todayAppliedCompaniesList.length;
    todayPieChartPercentage = [];

    if (todayTotalAppliedCompany == 0) {
      doHaveTodayData = false;
      notifyListeners();
    } else {
      doHaveTodayData = true;
      for (var i = 0; i < status.length; i++) {
        List matchingItems = _todayAppliedCompaniesList
            .where((item) =>
                item.currentStatus.trim().toLowerCase() ==
                status[i].trim().toLowerCase())
            .toList();

        todayStatusCounts.add(matchingItems.length);
      }
      for (var i = 0; i < todayStatusCounts.length; i++) {
        double holdValue =
            (todayStatusCounts[i] / todayTotalAppliedCompany) * 100;
        todayPieChartPercentage.add(holdValue);
      }
      notifyListeners();
    }
  }
}
