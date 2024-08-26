import 'package:intl/intl.dart';

String exelDateConvertor(int serialDateNumber) {
  final DateTime baseDate = DateTime(1900, 1, 1);

  final int daysSinceBase = serialDateNumber - 2;

  final DateTime date = baseDate.add(Duration(days: daysSinceBase));

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  if (serialDateNumber != 1) {
    return formatter.format(date);
  }else{
    return '-  -';
  }
}
