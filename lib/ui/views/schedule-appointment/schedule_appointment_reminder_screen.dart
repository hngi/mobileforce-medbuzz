import 'dart:ui';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../size_config/config.dart';
import '../../size_config/config.dart';

class ScheduleAppointmentScreen extends StatefulWidget {
  @override
  _ScheduleAppointmentScreenState createState() =>
      _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  //Table calendar object class
  CalendarController _controller;
  final TextEditingController _typeOfAppointmentController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  //Instantiating a Config object to handle responsiveness
  Config config = Config();

  var _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  var _currentMonthSelected = "January";

  @override
  Widget build(BuildContext context) {
//    double height = MediaQuery.of(context).size.height;

    print(Config.xMargin(context, 1));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
            color: Theme.of(context).primaryColorDark,
            icon: Icon(Icons.keyboard_backspace),
            // This function navigates to the previous screen
            onPressed: () {}),
        title: Text(
          'Add your appointments',
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 35),
          child: ListView(
            children: <Widget>[
              // Widget from the table calendar object, this widget could later be replaced with a ListView.builder
//              TableCalendar(
//                  initialCalendarFormat: CalendarFormat.week,
//                  headerStyle: HeaderStyle(
//                    formatButtonVisible: false,
//                    centerHeaderTitle: true,
//                  ),
//                  onDaySelected: (date, event) {},
//                  calendarStyle: CalendarStyle(
//                      selectedColor: Theme.of(context).primaryColor),
//                  calendarController: _controller),
              Center(
                child: DropdownButton<String>(
                  style: TextStyle(
                    color: Color(0xFFC4C4C4),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFFC4C4C4),
                  ),
                  items: _months.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (String newMonthSelected) {
                    setState(() {
                      this._currentMonthSelected = newMonthSelected;
                    });
                  },
                  value: _currentMonthSelected,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                height: Config.yMargin(context, 9),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    DateAndDay(
                      date: '12',
                      day: 'Thurs',
                      colour: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 4.3),
                    ),
                    DateAndDay(
                      date: '13',
                      day: 'Fri',
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 4.3),
                    ),
                    DateAndDay(
                      date: '14',
                      day: 'Sat',
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 4.3),
                    ),
                    DateAndDay(
                      date: '15',
                      day: 'Sun',
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 4.3),
                    ),
                    DateAndDay(
                      date: '16',
                      day: 'Mon',
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 4.3),
                    ),
                    DateAndDay(
                      date: '17',
                      day: 'Tues',
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 4.3),
                    ),
                    DateAndDay(
                      date: '18',
                      day: 'Wed',
                    )
                  ],
                ),
              ),
              Container(
                height: Config.yMargin(context, 0.5),
                width: Config.xMargin(context, 9.24),
                child: Text('h'),
                decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0))),
              ),
              SizedBox(
                height: Config.xMargin(context, 2.43),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Time',
                    style: TextStyle(
                      color: Color(0xFFC4C4C4),
                    ),
                  ),
//                  Container(
//                    height: height * 0.2,
//                    transform: Matrix4.translationValues(
//                        0.0, -Config.yMargin(context, 10), 0.0),
//                    //TimePickerSpinner a plugin that was tweaked to give the required result
//                    child: TimePickerSpinner(
//                      is24HourMode: false,
//                      isForce2Digits: true,
//                      spacing: 60,
//                      itemHeight: height * 0.1,
//                      alignment: Alignment.center,
//                      onTimeChange: (val) {},
//                    ),
//                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Timer(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Appointment For:',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColorDark),
                  ),
                  SizedBox(
                    height: Config.yMargin(context, 3.65),
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(47, 14, 37, 27),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'What appointment are you going for',
                            style: TextStyle(
                              color: Color(0xFFC4C4C4),
                            ),
                          ),
                          TextField(
                            // Input for type of appointment
                            controller: _typeOfAppointmentController,
                          ),
                          SizedBox(
                            height: Config.yMargin(context, 2.43),
                          ),
                          Text(
                            'Write a note',
                            style: TextStyle(
                              color: Color(0xFFC4C4C4),
                            ),
                          ),
                          SizedBox(
                            height: Config.yMargin(context, 2.43),
                          ),
                          TextField(
                            //Input field for additional notes
                            controller: _noteController,
                            selectionHeightStyle: BoxHeightStyle.tight,
                            keyboardType: TextInputType.multiline,
                            maxLines: 9,
                            decoration: InputDecoration(
                                filled: true, border: OutlineInputBorder()),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Config.yMargin(context, 8.63),
              ),
              Container(
                height: Config.yMargin(context, 8.63),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Save',
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                  ),
                  // When this button is pressed, it saves the appointment to the DB
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              '09',
              style: TextStyle(
                fontSize: Config.textSize(context, 6.07),
              ),
            ),
            Container(
              height: Config.yMargin(context, 0.3),
              width: Config.xMargin(context, 9.24),
              child: Text('h'),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0))),
            ),
          ],
        ),
        SizedBox(
          width: Config.xMargin(context, 6.07),
        ),
        Text(
          ':',
          style: TextStyle(
            fontSize: Config.textSize(context, 6.07),
            color: Color(0xFFC4C4C4),
          ),
        ),
        SizedBox(
          width: Config.xMargin(context, 6.07),
        ),
        Column(
          children: <Widget>[
            Text(
              '09',
              style: TextStyle(
                fontSize: Config.textSize(context, 6.07),
              ),
            ),
            Container(
              height: Config.yMargin(context, 0.3),
              width: Config.xMargin(context, 9.24),
              child: Text('h'),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0))),
            ),
          ],
        ),
        SizedBox(
          width: Config.xMargin(context, 6.07),
        ),
        Text(
          ':',
          style: TextStyle(
            fontSize: Config.textSize(context, 6.07),
            color: Color(0xFFC4C4C4),
          ),
        ),
        SizedBox(
          width: Config.xMargin(context, 6.07),
        ),
        Column(
          children: <Widget>[
            Text(
              'AM',
              style: TextStyle(
                fontSize: Config.textSize(context, 6.07),
              ),
            ),
            Container(
              height: Config.yMargin(context, 0.3),
              width: Config.xMargin(context, 9.24),
              child: Text('h'),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0))),
            ),
          ],
        ),
      ],
    );
  }
}

class DateAndDay extends StatelessWidget {
  DateAndDay({this.colour, @required this.day, @required this.date});

  final Color colour;
  final String day;
  final String date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            Text(
              date,
              style: TextStyle(
                  fontSize: Config.textSize(context, 7.29),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              day,
              style: TextStyle(
                  color: Color(0xFFC4C4C4),
                  fontSize: Config.textSize(context, 2.92)),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: Config.yMargin(context, 0.3),
              width: Config.xMargin(context, 9.24),
              child: Text('h'),
              decoration: BoxDecoration(
                  color: colour,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0))),
            ),
          ],
        ),
      ),
    );
  }
}
