import 'package:flutter/material.dart';
import 'package:jobscope/models/self_applied_companies_model.dart';
import 'package:jobscope/services/googe_sheet.dart';

class SelfAppliedCompaniesProvider extends ChangeNotifier {
  List<SelfAppliedCompaniesModel> selfAppliedCompaniesList =[];

  void fechDataFromSheet()async{
    selfAppliedCompaniesList = await GoogleSheet.getAll();
  }
}