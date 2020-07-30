import 'dart:math';

import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../../../core/database/fitness_reminder.dart';
import '../../../core/models/fitness_reminder_model/fitness_reminder.dart';
import '../../../core/notifications/fitness_notification_manager.dart';
import '../../size_config/config.dart';
import 'package:MedBuzz/ui/widget/snack_bar.dart';

class FitnessEditScreen extends StatefulWidget {
  final FitnessReminder fitnessModel;
  final bool isEdit;

  FitnessEditScreen({Key key, this.fitnessModel, this.isEdit = false})
      : super(key: key);

  @override
  _FitnessEditScreenState createState() => _FitnessEditScreenState();
}

class _FitnessEditScreenState extends State<FitnessEditScreen> {
  @override
  Widget build(BuildContext context) {
    // bool _changedName = false;
    final fitnessDB = Provider.of<FitnessReminderCRUD>(context);
    fitnessDB.getReminders();
    // var fitnessDB = Provider.of<FitnessReminderCRUD>(context);

    String appBar = widget.isEdit == true ? fitnessDB.edit : fitnessDB.add;
    // TextEditingController descController = TextEditingController();
    // FocusNode focusNode = FocusNode();

    // if (fitnessDB.isEditing && _changedName == false) {
    //   descController.text = fitnessDB.description;
    //   _changedName = true;
    // }

    FitnessNotificationManager fitnessNotificationManager =
        FitnessNotificationManager();
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    var model = Provider.of<FitnessReminderCRUD>(context);

    void printStatements() {
      print([
//        newReminder.id,
        model.fitnessType[model.selectedIndex],
        model.activityType[model.selectedIndex],
        model.selectedIndex,
        model.startDate,
        model.endDate,
        model.description,
        model.activityTime
      ]);
    }

    Future<Null> selectTime(BuildContext context) async {
      // var model = Provider.of<FitnessReminderCRUD>(context);
      widget.isEdit == true
          ? model.updateActivityTime(TimeOfDay(
              hour: widget.fitnessModel.activityTime[0],
              minute: widget.fitnessModel.activityTime[1]))
          : null;
      TimeOfDay currentTime = TimeOfDay.now();
      TimeOfDay selectedTime = await showTimePicker(
            context: context,
            initialTime: model.activityTime,
          ) ??
          model.activityTime;
      bool today = model.startDate.difference(DateTime.now()).inDays == 0;
      if (today && selectedTime.hour < currentTime.hour && !widget.isEdit) {
        CustomSnackBar.showSnackBar(context,
            text: "Cannot set reminder in the past");
      } else {
        if (selectedTime != null && selectedTime != model.activityTime) {
          // setState(() {
          model.updateActivityTime(selectedTime);
          // });
        }
      }
    }

    Future<Null> selectStartDate(BuildContext context) async {
      // var model = Provider.of<FitnessReminderCRUD>(context);
      widget.isEdit == true
          ? model.updateStartDate(widget.fitnessModel.startDate)
          : null;
      final DateTime selectedDate = await showDatePicker(
              context: context,
              initialDate: model.startDate,
              firstDate: DateTime(model.startDate.year),
              lastDate: DateTime(model.startDate.year + 1)) ??
          model.startDate;
      if (selectedDate.difference(model.startDate).inDays < 0) {
        CustomSnackBar.showSnackBar(context,
            text: "Cannot set start date in the past");
      } else {
        if (selectedDate != null && selectedDate != model.startDate) {
          // setState(() {
          model.updateStartDate(selectedDate);
          // });

          print('${model.startDate}');
        }
      }
    }

    Future<Null> selectEndDate(BuildContext context) async {
      // var model = Provider.of<FitnessReminderCRUD>(context);
      widget.isEdit == true
          ? model.updateEndDate(widget.fitnessModel.endDate)
          : null;

      final DateTime selectedDate = await showDatePicker(
              context: context,
              initialDate: model.endDate,
              firstDate: DateTime(model.endDate.year),
              lastDate: DateTime(model.endDate.year + 1)) ??
          model.endDate;
      if (selectedDate.difference(model.endDate).inDays < 0) {
        CustomSnackBar.showSnackBar(context,
            text: "Cannot set end date in the past");
      } else {
        if (selectedDate != null && selectedDate != model.endDate) {
          // setState(() {
          model.updateEndDate(selectedDate);
          // });

          print('${model.startDate}');
        }
      }
    }

    void _successDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Config.xMargin(context, 8))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('images/check.png'),
                SizedBox(
                  height: Config.yMargin(context, 5),
                ),
                Text("Reminder Successfully added!"),
              ],
            ),
          );
        },
      );
    }

    Widget oneDay() {
      return Row(
        children: <Widget>[
          Expanded(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    hintText: '${model.selectedDay}',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: Config.xMargin(context, 5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Config.xMargin(context, 5),
                        ),
                      ),
                    ),
                  ),
                  isEmpty: false,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: Config.xMargin(context, 8),
                      ),
                      value: model.selectedDay,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDay = newValue;
                          state.didChange(newValue);
                        });
                        model.updateDay(newValue);
                      },
                      items: model.days.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    Widget twoDays() {
      return Row(
        children: <Widget>[
          Expanded(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    hintText: '${model.selectedDay}',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: Config.xMargin(context, 5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Config.xMargin(context, 5),
                        ),
                      ),
                    ),
                  ),
                  isEmpty: false,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: Config.xMargin(context, 8),
                      ),
                      value: model.selectedDay,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDay = newValue;
                          state.didChange(newValue);
                        });
                        model.updateDay(newValue);
                      },
                      items: model.days.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    hintText: '${model.selectedDay2}',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: Config.xMargin(context, 5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Config.xMargin(context, 5),
                        ),
                      ),
                    ),
                  ),
                  isEmpty: false,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: Config.xMargin(context, 8),
                      ),
                      value: model.selectedDay2,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDay2 = newValue;
                          state.didChange(newValue);
                        });
                        model.updateDay(newValue);
                      },
                      items: model.days.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      );
    }

    Widget threeDays() {
      return Row(
        children: <Widget>[
          Expanded(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    hintText: '${model.selectedDay}',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: Config.xMargin(context, 5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Config.xMargin(context, 5),
                        ),
                      ),
                    ),
                  ),
                  isEmpty: false,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: Config.xMargin(context, 8),
                      ),
                      value: model.selectedDay,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDay = newValue;
                          state.didChange(newValue);
                        });
                        model.updateDay(newValue);
                      },
                      items: model.days.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    hintText: '${model.selectedDay2}',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: Config.xMargin(context, 5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Config.xMargin(context, 5),
                        ),
                      ),
                    ),
                  ),
                  isEmpty: false,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: Config.xMargin(context, 8),
                      ),
                      value: model.selectedDay2,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDay2 = newValue;
                          state.didChange(newValue);
                        });
                        model.updateDay(newValue);
                      },
                      items: model.days.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    hintText: '${model.selectedDay3}',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: Config.xMargin(context, 5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Config.xMargin(context, 5),
                        ),
                      ),
                    ),
                  ),
                  isEmpty: false,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: Config.xMargin(context, 8),
                      ),
                      value: model.selectedDay3,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDay3 = newValue;
                          state.didChange(newValue);
                        });
                        model.updateDay(newValue);
                      },
                      items: model.days.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    Widget fourDays() {
      return Row(
        children: <Widget>[
          Expanded(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    hintText: '${model.selectedDay}',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: Config.xMargin(context, 3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Config.xMargin(context, 5),
                        ),
                      ),
                    ),
                  ),
                  isEmpty: false,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: Config.xMargin(context, 5),
                      ),
                      value: model.selectedDay,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDay = newValue;
                          state.didChange(newValue);
                        });
                        model.updateDay(newValue);
                      },
                      items: model.days.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    hintText: '${model.selectedDay2}',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: Config.xMargin(context, 3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Config.xMargin(context, 5),
                        ),
                      ),
                    ),
                  ),
                  isEmpty: false,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: Config.xMargin(context, 5),
                      ),
                      value: model.selectedDay2,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDay2 = newValue;
                          state.didChange(newValue);
                        });
                        model.updateDay(newValue);
                      },
                      items: model.days.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    hintText: '${model.selectedDay3}',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: Config.xMargin(context, 3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Config.xMargin(context, 5),
                        ),
                      ),
                    ),
                  ),
                  isEmpty: false,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: Config.xMargin(context, 5),
                      ),
                      value: model.selectedDay3,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDay3 = newValue;
                          state.didChange(newValue);
                        });
                        model.updateDay(newValue);
                      },
                      items: model.days.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    hintText: '${model.selectedDay4}',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: Config.xMargin(context, 3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Config.xMargin(context, 5),
                        ),
                      ),
                    ),
                  ),
                  isEmpty: false,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: Config.xMargin(context, 5),
                      ),
                      value: model.selectedDay4,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDay4 = newValue;
                          state.didChange(newValue);
                        });
                        model.updateDay(newValue);
                      },
                      items: model.days.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    Widget buildImageContainer(int index) {
      // var model = Provider.of<FitnessReminderCRUD>(context);
      // isEdit == true
      //     ? model.updateSelectedIndex(
      //         model.fitnessType.indexOf(fitnessModel.fitnesstype))
      //     : null;
      return GestureDetector(
        onTap: () {
          model.onSelectedFitnessImage(index);
          // print(model.updateSelectedIndex(index));
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(Config.xMargin(context, 1.5)),
                margin: EdgeInsets.only(right: Config.xMargin(context, 3)),
                height: Config.yMargin(context, 10),
                width: Config.xMargin(context, 18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: model.selectedIndex == index
                      ? Theme.of(context).primaryColor
                      : Color(0xffFCEDB8),
                ),
                child: Image(
                  image: AssetImage(model.activityType[index]),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
                child: Text(
              model.fitnessType[index],
              style: TextStyle(fontSize: 12),
            )),
          ],
        ),
      );
    }

    void setWeeklyNotification(
        FitnessReminder newReminder, String selectedDay) {
      int num = model.updateDay(selectedDay);
      Day dayNum = model.updateNameDay(selectedDay);
      String time = model.getDateTime().toString();
      DateTime now = DateTime.now();
      int randomId = Random().nextInt(999);
      String nId = '$num${now.year}${now.month}$randomId';

//      ${now.day}$hour$minutes

      String notifId = nId.length < 11 ? nId : nId.substring(0, 10);

      fitnessNotificationManager.showFitnessNotificationWeekly(
        id: int.parse(notifId),
        title: "Hey It's Time to Go For ${newReminder.fitnesstype}",
        body: "For ${model.minDaily} minutes",
        dy: dayNum,
        dateTime: model.getDateTime(),
      );
    }

    // isEdit == true
    //     ? model.updateSelectedIndex(
    //         model.fitnessType.indexOf(fitnessModel.fitnesstype))
    //     : null;
    // WidgetsBinding.instance.allowFirstFrame(x);

    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   model.updateSelectedIndex();
    // });
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(appBar,
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
            // navigation.pushFrom(context, FitnessSchedulesScreen());
            Navigator.pushReplacementNamed(
                context, RouteNames.fitnessSchedulesScreen);
          },
        ),
      ),
      body: Builder(
        builder: (context) => WillPopScope(
          onWillPop: () {
            Navigator.pushReplacementNamed(context, RouteNames.homePage);
            return Future.value(false);
          },
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Config.xMargin(context, 5)),
            child: Container(
              color: Theme.of(context).backgroundColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ScrollConfiguration(
                // behavior: ScrollBehavior(),
                behavior: ScrollBehavior(),
                child: GestureDetector(
                  onTap: () {
                    // if (focusNode.hasFocus) {
                    //   focusNode.unfocus();
                    // }
                  },
                  child: ListView(
                    children: <Widget>[
                      Text(
                        'Select Exercise',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.w600,
                            fontSize: Config.xMargin(context, 5)),
                      ),
                      SizedBox(height: Config.yMargin(context, 1.0)),
                      Container(
                        height: Config.yMargin(context, 14),
                        color: Theme.of(context).backgroundColor,
                        child: ListView.builder(
                          padding:
                              EdgeInsets.only(left: Config.xMargin(context, 0)),
                          scrollDirection: Axis.horizontal,
                          itemCount: model.fitnessType.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildImageContainer(index);
                          },
                        ),
                      ),
//

                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Config.xMargin(context, 0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 5),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: Config.yMargin(context, 1.5)),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                              maxLines: 5,
                              initialValue: widget.isEdit == true
                                  ? widget.fitnessModel.description
                                  : null,
                              onChanged: (val) => model.updateDescription(val),
                              // controller: descriptionTextController,
                              // controller: descController,
                              cursorColor: Theme.of(context).primaryColorDark,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: Config.xMargin(context, 5.5)),
                              decoration: InputDecoration(
                                hintText: 'Input Description... (Required)',
                                hintStyle: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Config.xMargin(context, 4.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Config.xMargin(context, 5))),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Config.xMargin(context, 5))),
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: Config.yMargin(context, 4.5)),
                      Text(
                        'Reminder Frequency',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold,
                            fontSize: Config.xMargin(context, 5.5)),
                      ),
                      SizedBox(height: Config.yMargin(context, 1.0)),
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
                              items: model.frequency.map((String time) {
                                return DropdownMenuItem<String>(
                                    value: time, child: Text(time));
                              }).toList(),
                              value: model.selectedFreq,
                              onChanged: (newFreq) {
                                // setState(() {
                                // model.selectedFreq = newFreq;
                                // });
                                model.updateFreq(newFreq);
                              }),
                        ),
                      ),
                      SizedBox(height: Config.xMargin(context, 4.5)),
                      model.selectedFreq == 'Daily'
                          ? Visibility(visible: false, child: oneDay())
                          : model.selectedFreq == 'Once Every Week'
                              ? oneDay()
                              : model.selectedFreq == 'Twice Every Week'
                                  ? twoDays()
                                  : model.selectedFreq == 'Thrice Every Week'
                                      ? threeDays()
                                      : fourDays(),

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
                                  focusColor:
                                      Theme.of(context).primaryColorLight,
                                  splashColor: Theme.of(context).primaryColor,
                                  child: Text(
                                    localizations
                                        .formatTimeOfDay(model.activityTime),
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
                                Icons.remove_circle,
                                size: 30,
                              ),
                              onPressed: () {
                                // setState(() {
                                model.decrementMinDaily();
                                // });
                              }),
                          Text(
                            '${(model.minDaily).toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: Config.textSize(context, 4),
                            ),
                          ),
                          IconButton(
                              color: Theme.of(context).primaryColor,
                              icon: Icon(
                                Icons.add_circle,
                                size: 30,
                              ),
                              onPressed: () {
                                // setState(() {

                                model.incrementMinDaily();
                                // });
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
                                'Start - ${localizations.formatShortDate(model.startDate)}',
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
                                'End  -  ${localizations.formatShortDate(model.endDate)}',
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Config.xMargin(context, 3))),
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontSize: Config.textSize(context, 5.5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //Navigate to home screen after saving details in db
                              onPressed: () async {
                                var timeSet = DateTime.parse(
                                    '${DateTime.now().toString().substring(0, 11)}' +
                                        '${model.activityTime.toString().substring(10, 15)}');
                                var now = DateTime.parse(
                                    DateTime.now().toString().substring(0, 16));

                                if (model.startDate.isAfter(model.endDate)) {
                                  CustomSnackBar.showSnackBar(
                                    context,
                                    text:
                                        "Start date cannot be after the end date",
                                  );
                                } else if (model.description.isEmpty) {
                                  CustomSnackBar.showSnackBar(
                                    context,
                                    text: "Please enter a description",
                                  );
                                } else if (timeSet.isBefore(now) &&
                                    model.startDate.day == DateTime.now().day &&
                                    model.endDate.day == DateTime.now().day) {
                                  CustomSnackBar.showSnackBar(context,
                                      text:
                                          "Cannot set time reminder in the past");
                                } else if (model.description.isNotEmpty) {
                                  if (widget.isEdit == false) {
                                    print('${model.description}');
                                    FitnessReminder newReminder =
                                        FitnessReminder(
                                            id: DateTime.now().toString(),
                                            activityTime: [
                                              model.activityTime.hour,
                                              model.activityTime.minute
                                            ],
                                            endDate: model.endDate,
                                            startDate: model.startDate,
                                            index: model.selectedIndex,
                                            description: model.description,
                                            minsperday: model.minDaily,
                                            fitnessfreq: model.selectedFreq,
                                            fitnesstype: model.fitnessType[
                                                model.selectedIndex]);
                                    await fitnessDB.addReminder(newReminder);
                                    String time =
                                        model.getDateTime().toString();
                                    String hour = time.substring(0, 2);
                                    String minutes = time.substring(3, 5);
                                    DateTime now = DateTime.now();
                                    String id =
                                        '${now.year}${now.month}${now.day}$hour$minutes';
                                    String notifId = id.length < 11
                                        ? id
                                        : id.substring(0, 10);

                                    printStatements();
//                                    var diff = model.endDate
//                                        .difference(model.startDate)
//                                        .inDays;
//                                    print(diff);
//                                    var selectedInterval = model.selectedFreq ==
//                                            'Daily'
//                                        ? 1
//                                        : model.selectedFreq == 'Every 2 days'
//                                            ? 2
//                                            : model.selectedFreq ==
//                                                    'Every 3 days'
//                                                ? 3
//                                                : model.selectedFreq ==
//                                                        'Every 4 days'
//                                                    ? 4
//                                                    : 1;
//
//                                    int numb = (diff / selectedInterval).ceil();
//                                    for (var i = 0; i < numb; i++) {
//                                      var timeValue = model.startDate.add(
//                                        Duration(days: selectedInterval * i),
//                                      );
//                                      fitnessNotificationManager
//                                          .showFitnessNotificationDaily(
//                                              id: model.startDate.day +
//                                                  timeValue.day +
//                                                  8000,
//                                              title:
//                                                  "Hey It's Time to Go For ${newReminder.fitnesstype}",
//                                              body:
//                                                  "For ${model.minDaily} minutes",
//                                              dateTime: DateTime.parse(
//                                                  '${timeValue.year}-${timeValue.month.toString().padLeft(2, '0')}-${timeValue.day.toString().padLeft(2, '0')} ${model.activityTime.hour.toString().padLeft(2, '0')}:${model.activityTime.minute.toString().padLeft(2, '0')}'));
//                                    }
                                    switch (model.selectedFreq) {
                                      case 'Daily':
                                        fitnessNotificationManager
                                            .showFitnessNotificationDaily(
                                                id: num.parse(notifId),
                                                title:
                                                    "Hey It's Time to Go For ${newReminder.fitnesstype}",
                                                body:
                                                    "For ${model.minDaily} minutes",
                                                dateTime: model.getDateTime());
                                        break;
                                      case 'Once Every Week':
                                        setWeeklyNotification(
                                            newReminder, model.selectedDay);
                                        break;
                                      case 'Twice Every Week':
                                        setWeeklyNotification(
                                            newReminder, model.selectedDay);
                                        setWeeklyNotification(
                                            newReminder, model.selectedDay2);
                                        break;
                                      case 'Thrice Every Week':
                                        setWeeklyNotification(
                                            newReminder, model.selectedDay);
                                        setWeeklyNotification(
                                            newReminder, model.selectedDay2);
                                        setWeeklyNotification(
                                            newReminder, model.selectedDay3);
                                        break;
                                      case 'Four Times Weekly':
                                        setWeeklyNotification(
                                            newReminder, model.selectedDay);
                                        setWeeklyNotification(
                                            newReminder, model.selectedDay2);
                                        setWeeklyNotification(
                                            newReminder, model.selectedDay3);
                                        setWeeklyNotification(
                                            newReminder, model.selectedDay4);
                                        break;
                                    }

                                    Navigator.popAndPushNamed(context,
                                        RouteNames.fitnessSchedulesScreen);
                                  } else {
                                    if (model.description.isNotEmpty) {
                                      print('${model.description}');
                                      FitnessReminder newReminder =
                                          FitnessReminder(
                                              id: widget.fitnessModel.id,
                                              activityTime: [
                                                model.activityTime.hour,
                                                model.activityTime.minute
                                              ],
                                              endDate: model.endDate,
                                              startDate: model.startDate,
                                              index: model.selectedIndex,
                                              description: model.description,
                                              minsperday: model.minDaily,
                                              fitnessfreq: model.selectedFreq,
                                              fitnesstype: model.fitnessType[
                                                  model.selectedIndex]);

                                      fitnessDB.editReminder(newReminder);
//
//                                      var diff = widget.fitnessModel.endDate
//                                          .difference(
//                                              widget.fitnessModel.startDate)
//                                          .inDays;
//                                      var selectedInterval = widget
//                                                  .fitnessModel.fitnessfreq ==
//                                              'Daily'
//                                          ? 1
//                                          : widget.fitnessModel.fitnessfreq ==
//                                                  'Every 2 days'
//                                              ? 2
//                                              : widget.fitnessModel
//                                                          .fitnessfreq ==
//                                                      'Every 3 days'
//                                                  ? 3
//                                                  : widget.fitnessModel
//                                                              .fitnessfreq ==
//                                                          'Every 4 days'
//                                                      ? 4
//                                                      : 1;
//
//                                      int numb =
//                                          (diff / selectedInterval).ceil();
//                                      for (var i = 0; i < numb; i++) {
//                                        var oldTimeValue =
//                                            widget.fitnessModel.startDate.add(
//                                          Duration(days: selectedInterval * i),
//                                        );
//                                        fitnessNotificationManager
//                                            .removeReminder(widget.fitnessModel
//                                                    .startDate.day +
//                                                oldTimeValue.day +
//                                                8000);
//                                      }
//
//                                      var newDiff = model.endDate
//                                          .difference(model.startDate)
//                                          .inDays;
//                                      var newSelectedInterval =
//                                          model.selectedFreq == 'Daily'
//                                              ? 1
//                                              : model.selectedFreq ==
//                                                      'Every 2 days'
//                                                  ? 2
//                                                  : model.selectedFreq ==
//                                                          'Every 3 days'
//                                                      ? 3
//                                                      : model.selectedFreq ==
//                                                              'Every 4 days'
//                                                          ? 4
//                                                          : 1;
//
//                                      int newNumb =
//                                          (newDiff / newSelectedInterval)
//                                              .ceil();
//                                      for (var i = 0; i < newNumb; i++) {
//                                        var timeValue = model.startDate.add(
//                                          Duration(
//                                              days: newSelectedInterval * i),
//                                        );
//                                        fitnessNotificationManager
//                                            .showFitnessNotificationDaily(
//                                                id: model.startDate.day +
//                                                    timeValue.day +
//                                                    8000,
//                                                title:
//                                                    "Hey It's Time to Go For ${newReminder.fitnesstype}",
//                                                body:
//                                                    "For ${model.minDaily} minutes",
//                                                dateTime: DateTime.parse(
//                                                    '${timeValue.year}-${timeValue.month.toString().padLeft(2, '0')}-${timeValue.day.toString().padLeft(2, '0')} ${model.activityTime.hour.toString().padLeft(2, '0')}:${model.activityTime.minute.toString().padLeft(2, '0')}'));
//                                      }
                                      String time =
                                          model.getDateTime().toString();
                                      String hour = time.substring(0, 2);
                                      String minutes = time.substring(3, 5);
                                      DateTime now = DateTime.now();
                                      String id =
                                          '${now.year}${now.month}${now.day}$hour$minutes';
                                      String notifId = id.length < 11
                                          ? id
                                          : id.substring(0, 10);

                                      printStatements();

                                      switch (model.selectedFreq) {
                                        case 'Daily':
                                          fitnessNotificationManager
                                              .showFitnessNotificationDaily(
                                                  id: num.parse(notifId),
                                                  title:
                                                      "Hey It's Time to Go For ${newReminder.fitnesstype}",
                                                  body:
                                                      "For ${model.minDaily} minutes",
                                                  dateTime:
                                                      model.getDateTime());
                                          break;
                                        case 'Once Every Week':
                                          setWeeklyNotification(
                                              newReminder, model.selectedDay);
                                          break;
                                        case 'Twice Every Week':
                                          setWeeklyNotification(
                                              newReminder, model.selectedDay);
                                          setWeeklyNotification(
                                              newReminder, model.selectedDay2);
                                          break;
                                        case 'Thrice Every Week':
                                          setWeeklyNotification(
                                              newReminder, model.selectedDay);
                                          setWeeklyNotification(
                                              newReminder, model.selectedDay2);
                                          setWeeklyNotification(
                                              newReminder, model.selectedDay3);
                                          break;
                                        case 'Four Times Weekly':
                                          setWeeklyNotification(
                                              newReminder, model.selectedDay);
                                          setWeeklyNotification(
                                              newReminder, model.selectedDay2);
                                          setWeeklyNotification(
                                              newReminder, model.selectedDay3);
                                          setWeeklyNotification(
                                              newReminder, model.selectedDay4);
                                          break;
                                      }

                                      print([
                                        newReminder.id,
                                        newReminder.fitnesstype,
                                        model.fitnessType[model.selectedIndex],
                                        model.activityType[model.selectedIndex],
                                        model.selectedIndex,
                                        model.startDate,
                                        model.endDate,
                                        model.description,
                                        model.activityTime
                                      ]);
                                      Navigator.popAndPushNamed(context,
                                          RouteNames.fitnessSchedulesScreen);
                                    }
                                  }
                                } else {
                                  CustomSnackBar.showSnackBar(context,
                                      text: "Please enter a brief description");
                                }
                              }),
                        ),
                      ),
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
      ),
    );
  }
}
