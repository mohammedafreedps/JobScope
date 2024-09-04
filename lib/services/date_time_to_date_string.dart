import 'package:intl/intl.dart';

String dateTimeToDateString(DateTime dateTime){
  return DateFormat('dd-MMM-yyyy').format(dateTime);
}