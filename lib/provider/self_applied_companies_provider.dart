import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/constants/graph_dash_values.dart';
import 'package:jobscope/models/self_applied_companies_model.dart';
import 'package:jobscope/services/date_time_to_date_string.dart';
import 'package:jobscope/services/date_time_to_google_sheet_serial_number.dart';
import 'package:jobscope/services/exel_date_convertor.dart';
import 'package:jobscope/services/googe_sheet.dart';

class SelfAppliedCompaniesProvider extends ChangeNotifier { 
  bool isCardDataLoading = true;
  bool doHaveTodayData = false;
  bool doHaveGrandData = false;
  List<SelfAppliedCompaniesModel> selfAppliedCompaniesList = [];
  List<SelfAppliedCompaniesModel> _selfAppliedCompaniesList = [];
  List<SelfAppliedCompaniesModel> _todayAppliedCompaniesList = [];
  Timer? _debounce;

  TextEditingController searchController = TextEditingController();


  int totalAppliedCompany = 0;

  int todayTotalAppliedCompany = 0;

  List<int> statusCounts = [];

  List<int> todayStatusCounts = [];

  List<double> pieChartPercentage = [];

  List<double> todayPieChartPercentage = [];

  int todayAppliedCompany = 0;
  int todayCalledCompany = 0;
  bool isGoalAchived = false;

  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController contactedPersonNameController = TextEditingController();
  TextEditingController contactedPersonNumberController =
      TextEditingController();
  TextEditingController callRecordingLinkController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  String currentStatus = 'No response after application';

  DateTime? createDate = DateTime.now();
  DateTime? companyConnectedDateTime;

  TextEditingController createdDateController = TextEditingController();
  TextEditingController companyConnectedDateController =
      TextEditingController();

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

  void reloadDelaidWithoutLodingIndication() async {
    await Future.delayed(const Duration(seconds: 2));
    _selfAppliedCompaniesList = await GoogleSheet.getAll();
    selfAppliedCompaniesList = _selfAppliedCompaniesList;
    if (searchController.text.isNotEmpty) {
      searchByTitle(searchController.text);
    }
    setUpGrandGraphData();
    setGoalCount();
    notifyListeners();
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

  void setGoalCount() {
    _todayAppliedCompaniesList = _selfAppliedCompaniesList
        .where((item) =>
            item.date ==
            dateTimeToGoogleSheetsSerialNumber(DateTime.now()).toString())
        .toList();
    todayAppliedCompany = _selfAppliedCompaniesList
        .where((item) =>
            item.date ==
            dateTimeToGoogleSheetsSerialNumber(DateTime.now()).toString())
        .toList()
        .length;
    todayCalledCompany = _todayAppliedCompaniesList
        .where((item) =>
            item.date ==
                dateTimeToGoogleSheetsSerialNumber(DateTime.now()).toString() &&
            item.callRecording.isNotEmpty)
        .toList()
        .length;
    if (todayAppliedCompany >= 10 && todayCalledCompany >= 2) {
      isGoalAchived = true;
      notifyListeners();
    } else {
      isGoalAchived = false;
      notifyListeners();
    }
  }

  void setCurrentStatus(String? value) {
    if (value != null) {
      currentStatus = value;
    }
    notifyListeners();
  }

  void appendRowToSheet() async {
    currentStatus = 'No response after application';
    int? addedRowNumber = await GoogleSheet.appendData([
      createdDateController.text.replaceAll('Created Date : ', ''),
      companyNameController.text,
      emailIdController.text,
      currentStatus,
      companyConnectedDateController.text
          .replaceAll('Company Connected Date : ', ''),
      contactedPersonNameController.text,
      contactedPersonNumberController.text,
      callRecordingLinkController.text,
      remarksController.text
    ]);
    setSheetColorSwich(currentStatus, addedRowNumber);
  }

  void deleteRowFromSheet(int rowIndex) {
    GoogleSheet.deleteRow(rowIndex);
    
  }

  void updateRowFromSheet(int index, bool setEditable) {
    if (setEditable) {
      clearInputs();
      currentStatus = 'No response after application';
      if (selfAppliedCompaniesList[index].date.isNotEmpty) {
        createdDateController.text = exelDateConvertor(
            int.tryParse(selfAppliedCompaniesList[index].date) ?? 0);
      }
      if (selfAppliedCompaniesList[index].companyConnectedDate.isNotEmpty) {
        companyConnectedDateController.text = exelDateConvertor(int.tryParse(
                selfAppliedCompaniesList[index].companyConnectedDate) ??
            0);
      }

      companyNameController.text = selfAppliedCompaniesList[index].companyName;
      emailIdController.text = selfAppliedCompaniesList[index].emailId;
      currentStatus = selfAppliedCompaniesList[index].currentStatus;

      contactedPersonNameController.text =
          selfAppliedCompaniesList[index].contactPersonName;
      contactedPersonNumberController.text =
          selfAppliedCompaniesList[index].contactPersonNumber;
      callRecordingLinkController.text =
          selfAppliedCompaniesList[index].callRecording;
      remarksController.text = selfAppliedCompaniesList[index].remarks;
    } else {

      GoogleSheet.editRow(selfAppliedCompaniesList[index].rowNumber, [
        createdDateController.text.replaceAll('Created Date : ', ''),
        companyNameController.text,
        emailIdController.text,
        currentStatus,
        companyConnectedDateController.text,
        contactedPersonNameController.text,
        contactedPersonNumberController.text,
        callRecordingLinkController.text,
        remarksController.text
      ]);

      setSheetColorSwich(
          currentStatus, selfAppliedCompaniesList[index].rowNumber);
    }
  }

  void setCompanyConnectedDate(BuildContext context) async {
    companyConnectedDateTime = await showDatePicker(
      context: context,
      firstDate: DateTime(2004),
      lastDate: DateTime(2090),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    secondary: AppColors.dangerColor,
                    primary: AppColors.secondaryColor,
                    surface: AppColors.greyColor),
                dialogBackgroundColor: AppColors.dangerColor,
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryColor))),
            child: child!);
      },
    );

    if (companyConnectedDateTime != null) {
      companyConnectedDateController.text =
          'Company Connected Date : ${dateTimeToDateString(companyConnectedDateTime!)}';
      notifyListeners();
    }
  }

  void setCreatedDateToday() {
    if (createDate == null) {
      createDate = DateTime.now();
    }
    createdDateController.text =
        'Created Date : ${dateTimeToDateString(createDate!)}';
    notifyListeners();
  }

  void setCreateDateCustom(BuildContext context) async {
    createDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2090),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    secondary: AppColors.dangerColor,
                    primary: AppColors.secondaryColor,
                    surface: AppColors.greyColor),
                dialogBackgroundColor: AppColors.dangerColor,
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryColor))),
            child: child!);
      },
    );
    if (createDate != null) {
      createdDateController.text =
          'Created Date : ${dateTimeToDateString(createDate!)}';
    }

    notifyListeners();
  }

  void clearInputs() {
    companyNameController.clear();
    emailIdController.clear();
    contactedPersonNameController.clear();
    contactedPersonNumberController.clear();
    callRecordingLinkController.clear();
    remarksController.clear();
    companyConnectedDateController.clear();
    createdDateController.clear();
  }
}

void setSheetColorSwich(String stuatus, int? addedRowNumber) {
  switch (stuatus) {
    case 'Rejected by me' || 'Rejected by company':
      if (addedRowNumber != null) {
        GoogleSheet.setColorToARow(
            addedRowNumber, StatusColorsForSheet.red3Color);
      }
      break;
    case 'Aptitude test completed' ||
          'HR round completed' ||
          'Technical round completed' ||
          'Final round completed' ||
          'Face to Face Interview Done' ||
          'Interview Scheduled' ||
          'Machine Test Received':
      if (addedRowNumber != null) {
        GoogleSheet.setColorToARow(
            addedRowNumber, StatusColorsForSheet.yellow3Color);
      }
      break;
    case 'Got an offer':
      if (addedRowNumber != null) {
        GoogleSheet.setColorToARow(
            addedRowNumber, StatusColorsForSheet.green3Color);
      }
      break;
    default:
      if (addedRowNumber != null) {
        GoogleSheet.setColorToARow(
            addedRowNumber, StatusColorsForSheet.whiteColor);
      }
  }
}
