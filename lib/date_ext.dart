import 'package:intl/intl.dart';
extension DateExt on DateTime{
  String format(String pattern){
    return DateFormat(pattern).format(this);
  }

  List<DateTime> week(){
    var res = <DateTime>[];

    DateTime startOfWeek = subtract(Duration(days: weekday - 1));
    res.add(startOfWeek);
    for(int i=1;i<7;i++){
      DateTime date = startOfWeek.add(Duration(days: i));
      res.add(date);
    }

    return res;
  }

  List<DateTime> preWeek(){
    return subtract(const Duration(days: 7)).week();
  }

  List<DateTime> nextWeek(){
    return add(const Duration(days: 7)).week();
  }

  bool isSameDay(DateTime date){
    return year == date.year && month == date.month && day == date.day;
  }
}