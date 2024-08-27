import 'package:gsheets/gsheets.dart';
import 'package:jobscope/constants/sheet_value.dart';
import 'package:jobscope/api_keys.dart';
import 'package:jobscope/models/self_applied_companies_model.dart';

class GoogleSheet {
  static Future<void> initialiseGoogleSheet() async {
    googleSheets = GSheets(SheetsApi.credentials);
    spreadSheet = await googleSheets!.spreadsheet(SheetsApi.mySheetApi);
    selfAppliedCompanies =
        await getWorkSheet(spreadSheet!, 'Self Applied Companies');
  }

  static Future<Worksheet?> getWorkSheet(
      Spreadsheet spreadSheet, String title) async {
    var worksheet = spreadSheet.worksheetByTitle(title);
    if (worksheet == null) {
    }
    return worksheet;
  }

  static Future<List<SelfAppliedCompaniesModel>> getAll() async {
    if (selfAppliedCompanies == null) {
      return [];
    }

    final data = await selfAppliedCompanies!.values.map.allRows();
    if (data == null) {
      return [];
    }

    List<SelfAppliedCompaniesModel> companies = data.map((row) {
      return SelfAppliedCompaniesModel.fromJson(row);
    }).toList();
    return companies.where((item)=> item.companyName.isNotEmpty).toList().reversed.toList();
  }
}
