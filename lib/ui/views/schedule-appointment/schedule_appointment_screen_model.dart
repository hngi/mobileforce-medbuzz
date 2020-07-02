import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MonthCount{
  String month;

  MonthCount({@required this.month});
}

List<MonthCount> monthValues = [
  MonthCount(month: 'January'),
  MonthCount(month: 'February'),
  MonthCount(month: 'March'),
  MonthCount(month: 'April'),
  MonthCount(month: 'May'),
  MonthCount(month: 'June'),
  MonthCount(month: 'July'),
  MonthCount(month: 'August'),
  MonthCount(month: 'September'),
  MonthCount(month: 'October'),
  MonthCount(month: 'November'),
  MonthCount(month: 'December'),
];


// Functions for the properties would be created and used in screen file
class ScheduleAppointmentModel extends ChangeNotifier {
  DateTime _today = DateTime.now();
  int _selectedDay;
  int _selectedMonth;
  dynamic _selectedTime;
  String _typeOfAppointment;
  String _note;

  ScheduleAppointmentModel(){
    this._selectedDay = _today.day;
    this._selectedMonth = _today.month;
    this._selectedTime = null;
    this._typeOfAppointment = '';
    this._note = '';

  }

  DateTime get today => _today;

  String get typeOfAppointment => _typeOfAppointment;

  String get note => _note;

  int get selectedDay => _selectedDay;
  setSelectedDay(int selectedDay) => _selectedDay = selectedDay;

  int get selectedMonth => _selectedMonth;
  setSelectedMonth(int selectedMonth) => _selectedMonth = selectedMonth;

  dynamic get selectedTime => _selectedTime;
  setSelectedTime(dynamic selectedTime) => _selectedTime = selectedTime;


  void updateSelectedMonth(String val){
    _selectedMonth = monthValues.indexWhere((element) => element.month == val) + 1;
    notifyListeners();
  }

  void createSchedule(){
    var dayValue = selectedDay.toString().length < 2 ? '0$selectedDay' : '$selectedDay';

    var monthValue = selectedMonth.toString().length < 2 ? '0$selectedMonth' : '$selectedMonth';

    var selectedDateTime = "${_today.year}-$monthValue-$dayValue $selectedTime";

    var selectedAppointmentType = typeOfAppointment.toString();

    var selectedNote = note.toString();


  }

  void updateSelectedDay(int dayIndex) {
    _selectedDay = dayIndex + 1;
    notifyListeners();
  }

  void updateSelectedTime(dynamic time) {
    _selectedTime = time;
    // notifyListeners();
  }

  bool isActive(index) {
    //increment index to match day index and compare
    return index + 1 == _selectedDay;
  }

  String get currentMonth {
    return monthValues[_selectedMonth - 1].month;
  }

  String get selectedMonthValue {
    return monthValues[_today.month - 1].month;
  }

  getWeekDay(index) {
    //increment index to match month index
    index++;
    int year = _today.year;
    //check for single digit months e.g. 1,2,3 to format to 01,02,03 strings
    String month = _selectedMonth.toString().length < 2
        ? '0$_selectedMonth'
        : '$_selectedMonth';
    String weekday = index.toString().length < 2 ? '0$index' : '$index';
    //formats date to format of 2020-06-20 i.e. YYYY-MM-DD
    String val = DateFormat.E().format(
      DateTime.parse('$year' + '-' + '$month' + '-' + '$weekday'),
    );

    return val;
  }

  int get daysInMonth {
    return DateUtil().daysInMonth(_selectedMonth, _today.year);
  }




}
