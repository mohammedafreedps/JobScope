class SelfAppliedCompaniesModel {
  String date;
  String companyName;
  String emailId;
  String currentStatus;
  String companyConnectedDate;
  String contactPersonName;
  String contactPersonNumber;
  String callRecording;
  String remarks;
  bool showRemark;

  SelfAppliedCompaniesModel({
    required this.date,
    required this.companyName,
    required this.emailId,
    required this.currentStatus,
    required this.companyConnectedDate,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.callRecording,
    required this.remarks,
    required this.showRemark
  });

  factory SelfAppliedCompaniesModel.fromJson(Map<String, dynamic> json) {
    return SelfAppliedCompaniesModel(
      date: json['Date'] ?? '',
      companyName: json['Company Name'] ?? '',
      emailId: json['Email Id'] ?? '',
      currentStatus: json['Current Status'] ?? '',
      companyConnectedDate: json['Company Connected Date'] ?? '',
      contactPersonName: json['Contact Person Name'] ?? '',
      contactPersonNumber: json['Contact person  number'] ?? '',
      callRecording: json['Call Recording'] ?? '',
      remarks: json['Remarks'] ?? '',
      showRemark: false
    );
  }
}
