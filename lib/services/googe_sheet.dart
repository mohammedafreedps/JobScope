import 'package:googleapis_auth/auth_io.dart';
import 'package:gsheets/gsheets.dart';
import 'package:jobscope/constants/sheet_value.dart';
import 'package:jobscope/api_keys.dart';
import 'package:jobscope/models/self_applied_companies_model.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;

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
    if (worksheet == null) {}

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

    List<SelfAppliedCompaniesModel> companies = [];
    for (var i = 0; i < data.length; i++) {
      final row = data[i];
      int rowNumber = i + 2;

      companies.add(SelfAppliedCompaniesModel.fromJson(row, rowNumber));
    }

    return companies
        .where((item) => item.companyName.isNotEmpty)
        .toList()
        .reversed
        .toList();
  }

  static void appendData(List<String> datas) {
    if (selfAppliedCompanies != null) {
      selfAppliedCompanies!.values.appendRow(datas);
    }
  }

  static void deleteRow(int rowIndex) async {
    if (selfAppliedCompanies != null) {
      await selfAppliedCompanies!.deleteRow(rowIndex);
    }
  }

  static void editRow(int rowIndex, List<String> values) async {
    if (selfAppliedCompanies != null) {
      await selfAppliedCompanies!.values.insertRow(rowIndex, values);
    }
  }

  static void setColorToARow(int row, Map<String, double> color) async {
    final cruden = ServiceAccountCredentials.fromJson(SheetsApi.credentials);
    final scopes = [sheets.SheetsApi.spreadsheetsScope];
    final client = await clientViaServiceAccount(cruden, scopes);
    final shApi = sheets.SheetsApi(client);
    final requests = [
      sheets.Request(
        repeatCell: sheets.RepeatCellRequest(
          range: sheets.GridRange(
            sheetId: 1772288334,
            startRowIndex: row - 1,
            endRowIndex: row,
            startColumnIndex: 0,
            endColumnIndex: null,
          ),
          cell: sheets.CellData(
            userEnteredFormat: sheets.CellFormat(
              backgroundColor: sheets.Color(
                alpha: color['a'],
                red: color['r'],
                green: color['g'],
                blue: color['b'],
              ),
            ),
          ),
          fields: 'userEnteredFormat(backgroundColor)',
        ),
      ),
    ];
    final batchUpdateRequest =
        sheets.BatchUpdateSpreadsheetRequest(requests: requests);
    await shApi.spreadsheets
        .batchUpdate(batchUpdateRequest, SheetsApi.mySheetApi);
  }
}
