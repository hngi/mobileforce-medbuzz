import 'dart:ui';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/widget/appBar.dart';
import 'package:MedBuzz/ui/widget/scrollable_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../size_config/config.dart';
import 'package:MedBuzz/ui/widget/time_wheel.dart';
import 'schedule_appointment_screen_model.dart';

class ScheduleAppointmentScreen extends StatelessWidget {
  final String payload;
  //Table calendar object class
  final TextEditingController _typeOfAppointmentController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final ScheduleAppointmentModel appointmentSchedule =
      ScheduleAppointmentModel();

  ScheduleAppointmentScreen({Key key, this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<ScheduleAppointmentModel>(context);
    Color bgColor = Theme.of(context).backgroundColor;
    return Scaffold(
      appBar: appBar(context: context, title: 'Add your appointment'),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(
              Config.xMargin(context, 5),
              Config.yMargin(context, 1),
              Config.xMargin(context, 5),
              Config.yMargin(context, 5)),
          color: bgColor,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Center(
                child: DropdownButton<String>(
                  underline: Container(),
                  style: TextStyle(
                    color: Color(0xFFC4C4C4),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFFC4C4C4),
                  ),
                  items: model.months.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem,
                        style: TextStyle(
                            fontSize: Config.textSize(context, 4.8),
                            color: Theme.of(context).hintColor),
                      ),
                    );
                  }).toList(),
                  onChanged: (String newMonthSelected) {
                    model.updateSelectedMonth(newMonthSelected);
                  },
                  value: model.currentMonthSelected,
                ),
              ),
              SizedBox(
                height: Config.yMargin(context, 3),
              ),
              Container(

                  // height helps to stop overflowing of this widget into divider
                  height: Config.yMargin(context, 15),
                  child: ScrollableCalendar(
                    model: model,
                  )
                  //ListView(
                  //   // To be replaced with a ListView builder showing correct date date from DB
                  //   scrollDirection: Axis.horizontal,
                  //   children: <Widget>[
                  //     DateAndDay(
                  //       date: '12',
                  //       day: 'Thurs',
                  //       colour: Theme.of(context).primaryColor,
                  //     ),
                  //     SizedBox(
                  //       width: Config.xMargin(context, 4.3),
                  //     ),
                  //     DateAndDay(
                  //       date: '13',
                  //       day: 'Fri',
                  //     ),
                  //     SizedBox(
                  //       width: Config.xMargin(context, 4.3),
                  //     ),
                  //     DateAndDay(
                  //       date: '14',
                  //       day: 'Sat',
                  //     ),
                  //     SizedBox(
                  //       width: Config.xMargin(context, 4.3),
                  //     ),
                  //     DateAndDay(
                  //       date: '15',
                  //       day: 'Sun',
                  //     ),
                  //     SizedBox(
                  //       width: Config.xMargin(context, 4.3),
                  //     ),
                  //     DateAndDay(
                  //       date: '16',
                  //       day: 'Mon',
                  //     ),
                  //     SizedBox(
                  //       width: Config.xMargin(context, 4.3),
                  //     ),
                  //     DateAndDay(
                  //       date: '17',
                  //       day: 'Tues',
                  //     ),
                  //     SizedBox(
                  //       width: Config.xMargin(context, 4.3),
                  //     ),
                  //     DateAndDay(
                  //       date: '18',
                  //       day: 'Wed',
                  //     )
                  //   ],
                  // ),
                  ),
              SizedBox(
                height: Config.yMargin(context, 1),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Time',
                    style: TextStyle(
                        fontSize: Config.textSize(context, 4.8),
                        color: Theme.of(context).hintColor),
                  ),
                  SizedBox(
                    height: Config.yMargin(context, 3.2),
                  ),
                  Container(
                    child: TimeWheel(
                      updateTimeChanged: (value) =>
                          appointmentSchedule.updateSelectedTime(value),
                    ),
                  ),
                  SizedBox(
                    height: Config.yMargin(context, 3.5),
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
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontSize: Config.textSize(context, 5.5),
                    ),
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

class DateAndDay extends StatefulWidget {
  DateAndDay({this.colour, @required this.day, @required this.date});

  Color colour;
  final String day;
  final String date;

  @override
  _DateAndDayState createState() => _DateAndDayState();
}

class _DateAndDayState extends State<DateAndDay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
//      onTap: () {
//        setState(() {
//          widget.colour = Theme.of(context).primaryColor;
//        });
//      },
      child: Container(
        child: Column(
          children: <Widget>[
            Text(
              widget.date,
              style: TextStyle(
                  fontSize: Config.textSize(context, 7.29),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              widget.day,
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
              decoration: BoxDecoration(
                color: widget.colour,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
