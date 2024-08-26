import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobscope/models/self_applied_companies_model.dart';
import 'package:jobscope/services/googe_sheet.dart';

class SelfAppliedCompaniesProvider extends ChangeNotifier {
  bool isCardDataLoading = true;
  List<SelfAppliedCompaniesModel> selfAppliedCompaniesList = [];
  List<SelfAppliedCompaniesModel> _selfAppliedCompaniesList = [];
  Timer? _debounce;
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

  void setShowRemark(int index){
    selfAppliedCompaniesList[index].showRemark = !selfAppliedCompaniesList[index].showRemark;
    notifyListeners();
  }
}
