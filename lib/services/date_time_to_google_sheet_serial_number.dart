int dateTimeToGoogleSheetsSerialNumber(DateTime dateTime) {
  final googleSheetsEpoch = DateTime(1899, 12, 30);

  final daysDifference = dateTime.difference(googleSheetsEpoch).inDays;

  return daysDifference;
}
