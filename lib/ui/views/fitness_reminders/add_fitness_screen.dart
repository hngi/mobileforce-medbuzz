import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/core/models/fitness_reminder.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import '../../../core/models/fitness_reminder.dart';
import '../../navigation/app_navigation/app_transition.dart';
import '../../size_config/config.dart';
import 'all_fitness_reminders_screen.dart';

class FitnessDescriptionScreen extends StatelessWidget {
  final FitnessModel;

  const FitnessDescriptionScreen({Key key, this.FitnessModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: add_fitness());
  }
}

class add_fitness extends StatefulWidget {
  FitnessModel fitnessModel;
  @override
  __fitnesssDescriptionState createState() => __fitnesssDescriptionState();
}

class __fitnesssDescriptionState extends State<add_fitness> {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(DiagnosticsProperty<Schedule>('schedule', schedule));
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  Navigation navigation = Navigation();
  final List activityType = [
    'images/cycle.png',
    'images/sprint.png',
    'images/swim.png'
  ];
  final List<String> fitnessTime = [
    'Daily',
    'Every 2 days',
    'Every 3 days',
    'Every 4 days'
  ];
//Instantiating a SizeConfig object to handle responsiveness
  String _selectedFreq = "Daily";
  Config config = Config();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TextEditingController nameController = TextEditingController();
  FocusNode focusNode = FocusNode();
  int index;
  // int _selectedActivity =0;
  int selectedFitnessType = 0;
  int minDaily = 60;
  TimeOfDay activityTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text('Edit Fitness',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
            )),
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Theme.of(context).primaryColorDark,
            size: Config.xMargin(context, 8),
          ),
          onPressed: () {
            navigation.pushFrom(context, FitnessSchedulesScreen());
            Navigator.pushReplacementNamed(
                context, RouteNames.fitnessSchedulesScreen);
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(
              context, RouteNames.fitnessSchedulesScreen);
          return Future.value(false);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Config.xMargin(context, 5)),
          child: Container(
            color: Theme.of(context).backgroundColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ScrollConfiguration(
              // behavior: ScrollBehavior(),
              behavior: ScrollBehavior(),
              child: GestureDetector(
                onTap: () {
                  if (focusNode.hasFocus) {
                    focusNode.unfocus();
                  }
                },
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: Config.yMargin(context, 1.0)),
                    Text(
                      'Name of fitness',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w600,
                          fontSize: Config.xMargin(context, 5)),
                    ),
                    SizedBox(height: Config.yMargin(context, 1.0)),
                    Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius:
                              BorderRadius.all((Radius.circular(5.0))),
                        ),
                      ),
                      child: TextFormField(
                        focusNode: focusNode,
                        controller: nameController,
                        cursorColor: Theme.of(context).primaryColorDark,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.xMargin(context, 5.5)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: Config.yMargin(context, 1.0),
                          ),
                          hintText: 'Input name',
                          hintStyle: TextStyle(
                              fontSize: Config.xMargin(context, 5),
                              color: Theme.of(context).hintColor),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorDark)),
//
                        ),
                      ),
                    ),
                    SizedBox(height: Config.yMargin(context, 5)),
                    Container(
                      height: Config.yMargin(context, 12),
                      color: Theme.of(context).backgroundColor,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: activityType.length,
                        itemBuilder: (_, index) => Row(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  selectedFitnessType = index;
                                });
                              },
                              child: Container(
                                child: Stack(children: <Widget>[
                                  Image.asset('${activityType[index]}'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40, horizontal: 50),
                                    child: Checkbox(
                                      onChanged: null,
                                      value: index == selectedFitnessType,
                                      //value: ,
                                      checkColor:
                                          Theme.of(context).backgroundColor,
                                    ),
                                  ),
                                ]),

                                // height: 170,
                              ),
                            ),
                            SizedBox(width: Config.xMargin(context, 1.1))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Config.yMargin(context, 4.5)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Reminder Frequency',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold,
                              fontSize: Config.xMargin(context, 5.5)),
                        ),
                        SizedBox(height: Config.xMargin(context, 4.5)),

//                      Row(
//                        //crossAxisAlignment: CrossAxisAlignment.,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
                        //  Expanded(
                        Container(
                          width: double.infinity,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0, style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all((Radius.circular(6.0))),
                            ),
                          ),
                          child: Center(
                            child: DropdownButton<String>(
                                underline: Text(''),
                                items: fitnessTime.map((String time) {
                                  return DropdownMenuItem<String>(
                                      value: time, child: Text(time));
                                }).toList(),
                                value: _selectedFreq,
                                onChanged: (newFreq) {
                                  setState(() {
                                    _selectedFreq = newFreq;
                                  });
                                }),
                          ),
                        ),

                        // ),

                        //      ]
                        //    ,
                        //   )
                      ],
                    ),
                    SizedBox(height: Config.xMargin(context, 4.5)),
                    Text(
                      'Set time For Fitness Activity',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w600,
                          fontSize: Config.xMargin(context, 5.0)),
                    ),
                    SizedBox(height: Config.xMargin(context, 4.5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                              ),
                              SizedBox(width: Config.xMargin(context, 1.5)),
                              InkWell(
                                focusColor: Theme.of(context).primaryColorLight,
                                splashColor: Theme.of(context).primaryColor,
                                child: Text(
                                  localizations.formatTimeOfDay(activityTime),
                                  style: TextStyle(
                                      fontSize: Config.xMargin(context, 4.2)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  Config.xMargin(context, 4.0))),
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Config.textSize(context, 4),
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          onPressed: () {
                            selectTime(context);
                          },
                        )
                      ],
                    ),
                    SizedBox(height: Config.xMargin(context, 4.5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            color: Theme.of(context).primaryColor,
                            icon: Icon(
                              Icons.add_circle,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                minDaily++;
                              });
                            }),
                        Text(
                          '$minDaily',
                          style: TextStyle(
                            fontSize: Config.textSize(context, 4),
                          ),
                        ),
                        IconButton(
                            color: Theme.of(context).primaryColor,
                            icon: Icon(
                              Icons.remove_circle,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                minDaily--;
                              });
                            }),
                      ],
                    ),
                    SizedBox(height: Config.xMargin(context, 4.5)),
                    Text(
                      'Duration',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w600,
                          fontSize: Config.xMargin(context, 5.0)),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Start - ${localizations.formatShortDate(startDate)}',
                              style: TextStyle(
                                fontSize: Config.xMargin(context, 4),
                              ),
                            ),
                            SizedBox(width: Config.xMargin(context, 3)),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Config.xMargin(context, 4.0))),
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Config.textSize(context, 4),
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                              onPressed: () {
                                selectStartDate(context);
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'End  -  ${localizations.formatShortDate(endDate)}',
                              style: TextStyle(
                                  fontSize: Config.xMargin(context, 4)),
                            ),
                            SizedBox(width: Config.xMargin(context, 3)),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Config.xMargin(context, 4.0))),
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Config.textSize(context, 4),
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                              onPressed: () {
                                selectEndDate(context);
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Config.yMargin(context, 5),
                    ),
                    Center(
                        child: Container(
                      height: Config.yMargin(context, 6.5),
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        //Navigate to home screen after saving details in db
                        onPressed: () {
                          if (nameController.text.isNotEmpty) {
                            print('${nameController.text}');

                            var difference =
                                endDate.difference(startDate).inHours;

                            if (difference == 0) {
                              showSnackBar(context,
                                  text:
                                      "Start date should be different from end date");
                            } else {
//                                 navigation.pushFrom(
//                                     context, );
                            }
                          } else {
                            showSnackBar(context);
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Config.textSize(context, 4),
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        color: Theme.of(context).primaryColor,

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Config.xMargin(context, 4.0))),
                      ),
                    )),
                    SizedBox(
                      height: Config.yMargin(context, 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> selectTime(BuildContext context) async {
    TimeOfDay currentTime = TimeOfDay.now();
    final TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: activityTime,
    );
    bool today = startDate.difference(DateTime.now()) == 0;
    if (today && selectedTime.hour < currentTime.hour) {
      showSnackBar(context, text: "Cannot set reminder in the past");
    } else {
      if (selectedTime != null && selectedTime != activityTime) {
        setState(() {
          activityTime = selectedTime;
        });
      }
    }
  }

  void showSnackBar(BuildContext context, {String text: 'Enter Valid Time'}) {
    SnackBar snackBar = SnackBar(
      backgroundColor: Theme.of(context).buttonColor.withOpacity(.9),
      duration: Duration(seconds: 2),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: Config.textSize(context, 5.3),
            color: Theme.of(context).primaryColorLight),
      ),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<Null> selectStartDate(BuildContext context) async {
    final DateTime selectedDate = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(startDate.year),
        lastDate: DateTime(startDate.year + 1));
    if (selectedDate.difference(startDate).inDays < 0) {
      showSnackBar(context, text: "Cannot set reminder in the past");
    } else {
      if (selectedDate != null && selectedDate != startDate) {
        setState(() {
          startDate = selectedDate;
        });

        print('$startDate');
      }
    }
  }

  Future<Null> selectEndDate(BuildContext context) async {
    final DateTime selectedDate = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(endDate.year),
        lastDate: DateTime(endDate.year + 1));
    if (selectedDate.difference(endDate).inDays < 0) {
      showSnackBar(context, text: "Cannot set reminder in the past");
    } else {
      if (selectedDate != null && selectedDate != endDate) {
        setState(() {
          endDate = selectedDate;
        });

        print('$startDate');
      }
    }
  }
}
