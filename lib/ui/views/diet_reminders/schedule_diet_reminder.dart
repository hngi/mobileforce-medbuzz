import 'dart:math';

import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/diet_reminderDB.dart';
import 'package:MedBuzz/core/database/notification_data.dart';
import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:MedBuzz/core/models/notification_model/notification_model.dart';
import 'package:MedBuzz/core/notifications/diet_notification_manager.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/diet_reminders/diet_reminders_model.dart';
import 'package:MedBuzz/ui/widget/appBar.dart';
import 'package:MedBuzz/ui/widget/scrollable_calendar.dart';
import 'package:MedBuzz/ui/widget/time_wheel.dart';
import 'package:MedBuzz/ui/widget/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class ScheduleDietReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(body: AddDietReminderScreen());
}

class AddDietReminderScreen extends StatefulWidget {
  //this variable will determine if this screen will be for
  //adding or editing diet reminders
  final bool isEdit;

  AddDietReminderScreen({Key key, this.isEdit = false}) : super(key: key);

  @override
  _AddDietReminderScreenState createState() => _AddDietReminderScreenState();
}

class _AddDietReminderScreenState extends State<AddDietReminderScreen> {
  final notificationManager = DietNotificationManager();

  final TextEditingController mealNameController = TextEditingController();

  final TextEditingController mealDescController = TextEditingController();

  final FocusNode mealNameFocusNode = FocusNode();

  final FocusNode mealDescFocusNode = FocusNode();

  void unFocus() {
    if (mealNameFocusNode.hasFocus && mealDescFocusNode.hasFocus) {
      mealNameFocusNode.unfocus();
      mealNameFocusNode.unfocus();
    } else if (mealNameFocusNode.hasFocus) {
      mealNameFocusNode.unfocus();
    } else if (mealDescFocusNode.hasFocus) {
      mealDescFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    var db = Provider.of<DietReminderDB>(context);
    var notificationDB = Provider.of<NotificationData>(context);
    var model = Provider.of<DietReminderModel>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    hintText: '${model.selectedDayName}',
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
                      value: model.selectedDayName,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDayName = newValue;
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
                    hintText: '${model.selectedDayName}',
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
                      value: model.selectedDayName,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDayName = newValue;
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
                    hintText: '${model.selectedDayName2}',
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
                      value: model.selectedDayName2,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDayName2 = newValue;
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
                    hintText: '${model.selectedDayName}',
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
                      value: model.selectedDayName,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDayName = newValue;
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
                    hintText: '${model.selectedDayName2}',
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
                      value: model.selectedDayName2,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDayName2 = newValue;
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
                    hintText: '${model.selectedDayName3}',
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
                      value: model.selectedDayName3,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDayName3 = newValue;
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
                      value: model.selectedDayName,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDayName = newValue;
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
                    hintText: '${model.selectedDayName2}',
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
                      value: model.selectedDayName2,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDayName2 = newValue;
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
                    hintText: '${model.selectedDayName3}',
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
                      value: model.selectedDayName3,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDayName3 = newValue;
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
                    hintText: '${model.selectedDayName4}',
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
                      value: model.selectedDayName4,
                      isDense: true,
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          model.selectedDayName4 = newValue;
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

    Future<Null> selectTime(BuildContext context) async {
      // var model = Provider.of<FitnessReminderCRUD>(context);

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

    void setWeeklyNotification(DietModel newReminder, String selectedDay) {
      int num = model.updateDay(selectedDay);
      Day dayNum = model.updateNameDay(selectedDay);
      String time = model.getDateTime().toString();
      DateTime now = DateTime.now();
      int randomId = Random().nextInt(999);
      String nId = '$num${now.year}${now.month}$randomId';

//      ${now.day}$hour$minutes

      String notifId = nId.length < 11 ? nId : nId.substring(0, 10);

      notificationManager.showDietNotificationWeekly(
        id: int.parse(notifId),
        title: "Hey It's Time to take ${newReminder.dietName}",
        body: "For ${model.minDaily} minutes",
        dy: dayNum,
        dateTime: model.getDateTime(),
      );
    }

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        //Extracted appBar to widgets folder
        appBar: appBar(
            context: context,
            title: widget.isEdit ? 'Edit your diet' : 'Add diet',
            actions: widget.isEdit ? [_deleteButton(context)] : null),
        body: GestureDetector(
          onTap: () {
            unFocus();
          },
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  width: width,
                  padding: EdgeInsets.fromLTRB(
                      Config.xMargin(context, 5),
                      Config.yMargin(context, 1),
                      Config.xMargin(context, 5),
                      Config.yMargin(context, 5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(height: Config.yMargin(context, 5)),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _title(context, 'Meal Name'),
                            _verticalSpace(context),
                            _textField(context, mealNameFocusNode, 1, null,
                                'Fish and Chips', mealNameController),
                            SizedBox(height: Config.yMargin(context, 3.5)),
                            _title(context, 'Select meal category'),
                            _verticalSpace(context),
                            Container(
                                height: height * .15,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: model.foodClass.length,
                                    itemBuilder: (context, index) {
                                      var foodClass = model.foodClass[index];
                                      return InkWell(
                                          onTap: () {
                                            unFocus();
                                            model.updatesSelectedFoodClasses(
                                                foodClass.name);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right:
                                                    Config.xMargin(context, 4)),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                CircleAvatar(
                                                  radius: Config.xMargin(
                                                      context, 7.88),
                                                  backgroundColor: model
                                                          .selectedFoodClasses
                                                          .contains(
                                                              foodClass.name)
                                                      ? Theme.of(context)
                                                          .primaryColorLight
                                                      : Theme.of(context)
                                                          .buttonColor,
                                                  child: Stack(
                                                    fit: StackFit.loose,
                                                    children: <Widget>[
                                                      Positioned(
                                                        top: model
                                                                .selectedFoodClasses
                                                                .contains(
                                                                    foodClass
                                                                        .name)
                                                            ? Config.xMargin(
                                                                context, 3.88)
                                                            : Config.xMargin(
                                                                context, 3.88),
                                                        left: model
                                                                .selectedFoodClasses
                                                                .contains(
                                                                    foodClass
                                                                        .name)
                                                            ? Config.xMargin(
                                                                context, 3.88)
                                                            : Config.xMargin(
                                                                context, 3.88),
                                                        child: Image.asset(
                                                            foodClass.image,
                                                            height:
                                                                Config.yMargin(
                                                                    context,
                                                                    3.5),
                                                            width:
                                                                Config.yMargin(
                                                                    context,
                                                                    3.5)),
                                                      ),
                                                      model.selectedFoodClasses
                                                              .contains(
                                                                  foodClass
                                                                      .name)
                                                          ? Image.asset(
                                                              'images/check.png',
                                                              height: Config
                                                                  .yMargin(
                                                                      context,
                                                                      3.5),
                                                              width: Config
                                                                  .yMargin(
                                                                      context,
                                                                      3.5))
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                                _verticalSpace(context),
                                                Text(foodClass.name,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                        fontSize:
                                                            Config.textSize(
                                                                context, 3.74)))
                                              ],
                                            ),
                                          ));
                                    })),
                            SizedBox(height: Config.yMargin(context, 2.5)),
                            _title(context, 'Meal Description'),
                            _verticalSpace(context),
                            _textField(context, mealDescFocusNode, 6, 100,
                                'Optional description...', mealDescController),
                            SizedBox(height: Config.yMargin(context, 2.5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Time',
                                    style: TextStyle(
                                        fontSize: Config.textSize(context, 4.8),
                                        color: Theme.of(context).hintColor))
                              ],
                            ),
                            SizedBox(height: Config.yMargin(context, 2.5)),
                            TimeWheel(
                              updateTimeChanged: (val) {
                                //
                                //this unfocuses the text fields when the time wheel is being interacted with
                                unFocus();
                                //
                                model.updateSelectedTime(val);
                              },
                            ),
                            SizedBox(height: Config.yMargin(context, 2.5)),
                            Text(
                              'Reminder Frequency',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Config.xMargin(context, 5.5)),
                            ),
                            SizedBox(height: Config.yMargin(context, 1.5)),
                            // FormField<String>(
                            //     builder: (FormFieldState<String> state) {
                            //   return InputDecorator(
                            //     decoration: InputDecoration(
                            //         // labelStyle: textStyle,

                            //         errorStyle: TextStyle(
                            //             color: Colors.redAccent,
                            //             fontSize: 16.0),
                            //         hintText: 'Please select expense',
                            //         border: OutlineInputBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(5.0))),
                            //     // isEmpty: _currentSelectedValue == '',
                            //     child: DropdownButtonHideUnderline(
                            //       child: DropdownButton<String>(
                            //         value: model.selectedFreq,
                            //         isDense: true,
                            //         onChanged: (newFreq) {
                            //           // setState(() {
                            //           // model.selectedFreq = newFreq;
                            //           // });
                            //           model.updateFreq(newFreq);
                            //         },
                            //         items: model.frequency.map((String time) {
                            //           return DropdownMenuItem<String>(
                            //               value: time, child: Text(time));
                            //         }).toList(),
                            //       ),
                            //     ),
                            //   );
                            // }),

                            // SizedBox(height: Config.xMargin(context, 4.5)),
                            // model.selectedFreq == 'Daily'
                            //     ? Visibility(visible: false, child: oneDay())
                            //     : model.selectedFreq == 'Once Every Week'
                            //         ? oneDay()
                            //         : model.selectedFreq == 'Twice Every Week'
                            //             ? twoDays()
                            //             : model.selectedFreq ==
                            //                     'Thrice Every Week'
                            //                 ? threeDays()
                            //                 : fourDays(),

                            // SizedBox(height: Config.xMargin(context, 4.5)),
                            Container(
                              child: Row(
                                children: model.daysOfWeek
                                    .map((e) => Expanded(
                                            child: GestureDetector(
                                          onTap: () {
                                            //pass in the index + 1 so that the first element (mon) becomes the weekday 1 and the last index 6 becomes the weekday 7 (sun)
                                            model.updateSelectedDaysOfWeek(
                                                model.daysOfWeek.indexOf(e) +
                                                    1);
                                            print(model.selectedDaysOfWeek);
                                            // print(model.daysOfWeek.indexOf(e));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    Config.xMargin(context, 1)),
                                            padding: EdgeInsets.symmetric(
                                                vertical: Config.yMargin(
                                                    context, 0.7),
                                                horizontal:
                                                    Config.xMargin(context, 1)),
                                            color: model.selectDayColor(
                                                context,
                                                model.daysOfWeek.indexOf(e) +
                                                    1),
                                            child: Text(
                                              e,
                                              style: TextStyle(
                                                  color:
                                                      model.selectDayTextColor(
                                                          context,
                                                          model.daysOfWeek
                                                                  .indexOf(e) +
                                                              1)),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )))
                                    .toList(),
                              ),
                            ),
                            SizedBox(height: Config.yMargin(context, 4)),

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                      ),
                                      onPressed: () {
                                        selectStartDate(context);
                                      },
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          color:
                                              Theme.of(context).backgroundColor,
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
                            // Text(
                            //   'Reminder Frequency',
                            //   style: TextStyle(
                            //       color: Theme.of(context).primaryColorDark,
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: Config.xMargin(context, 5.5)),
                            // ),
                            // SizedBox(height: Config.yMargin(context, 1.0)),
                            // Container(
                            //   width: double.infinity,
                            //   decoration: ShapeDecoration(
                            //     shape: RoundedRectangleBorder(
                            //       side: BorderSide(
                            //           width: 1.0, style: BorderStyle.solid),
                            //       borderRadius:
                            //           BorderRadius.all((Radius.circular(6.0))),
                            //     ),
                            //   ),
                            //   child: Center(
                            //     child: DropdownButton<String>(
                            //         underline: Text(''),
                            //         items: model.frequency.map((String time) {
                            //           return DropdownMenuItem<String>(
                            //               value: time, child: Text(time));
                            //         }).toList(),
                            //         value: model.selectedFreq,
                            //         onChanged: (newFreq) {
                            //           print(newFreq);
                            //           // setState(() {
                            //           // model.selectedFreq = newFreq;
                            //           // });
                            //           model.updateFreq(newFreq);
                            //         }),
                            //   ),
                            // ),
                            // SizedBox(height: Config.xMargin(context, 4.5)),
                          ],
                        ),
                      ),
                      SizedBox(height: Config.yMargin(context, 5)),
                      Container(
                        width: width,
                        height: Config.yMargin(context, 8),
                        child: FlatButton(
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Config.xMargin(context, 3))),
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: Config.textSize(context, 5),
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            //Functions to save  reminder to db and schedule notification goes here
                            onPressed: () async {
                              if (mealNameController.text.isEmpty) {
                                CustomSnackBar.showSnackBar(context,
                                    text: 'Enter meal name');
                                return;
                              }
                              if (model.selectedDaysOfWeek.length == 0) {
                                CustomSnackBar.showSnackBar(context,
                                    text: 'You must select day(s) of the week');
                                return;
                              }

                              if (model.selectedFoodClasses.length < 1) {
                                CustomSnackBar.showSnackBar(context,
                                    text: 'Select at least one meal category');
                                return;
                              } else {
                                //using dateTime.now() cause no 2 reminders can be set at the same time, so it is unique
                                var reminderId = DateTime.now().toString();
                                var newReminder = DietModel(
                                    id: reminderId,
                                    foodClasses: model.selectedFoodClasses,
                                    dietName: mealNameController.text,
                                    description: mealDescController.text ?? '',
                                    startDate: model.getStartDate(),
                                    frequency: model.selectedFreq,
                                    activityTime: [
                                      model.activityTime.hour,
                                      model.activityTime.minute
                                    ],
                                    endDate: model.getEndDate(),
                                    minsperday: model.minDaily,
                                    time: [
                                      num.parse(
                                          model.selectedTime.substring(0, 2)),
                                      num.parse(
                                          model.selectedTime.substring(3, 5))
                                    ]);
                                db.addDiet(newReminder);
                                String time = model.getDateTime().toString();
                                String hour = time.substring(0, 2);
                                String minutes = time.substring(3, 5);
                                DateTime now = DateTime.now();
                                String id =
                                    '${now.year}${now.month}${now.day}${minutes}6000';
                                String notifId =
                                    id.length < 11 ? id : id.substring(0, 10);
                                int differenceInDays = newReminder.endDate
                                    .difference(newReminder.startDate)
                                    .inDays;
                                for (var i = 0; i < differenceInDays; i++) {
                                  DateTime currentDateBeingScheduledFor =
                                      newReminder.startDate
                                          .add(Duration(days: i));
                                  //we set once because there is a start and end date and we don't want it daily forever but within the start and end dates
                                  if (model.selectedDaysOfWeek.contains(
                                      currentDateBeingScheduledFor.weekday)) {
                                    String hour = currentDateBeingScheduledFor
                                        .hour
                                        .toString()
                                        .padLeft(2, '0');
                                    String minutes =
                                        currentDateBeingScheduledFor.minute
                                            .toString()
                                            .padLeft(2, '0');
                                    DateTime now = DateTime.now();
                                    String id =
                                        '${now.year}${now.month}${currentDateBeingScheduledFor.day}$hour$minutes';
                                    // print(id);
                                    //unique id because if we use notifId to set it, it will change any already set notification with that id instead of scheduling a new one, so we create a unique one by using the datetime currently being set for
                                    String recurrentNotifId = id.length < 11
                                        ? id
                                        : id.substring(0, 10);

                                    //only set it if it is part of the days of the week selected by the user
                                    NotificationModel notificationModel =
                                        NotificationModel(
                                      dateTime: currentDateBeingScheduledFor,
                                      id: recurrentNotifId.toString(),
                                      //we set the notification reminder Id to the original id so that we can keep track of the original reminder to which the notification belongs
                                      reminderId: reminderId,
                                      reminderType: 'diet-reminder',
                                      //no need to set isDone and isSkippoed, they are both false by default.
                                    );
                                    //add the notification to the db then schedule it
                                    // print(notificationModel);
                                    await notificationDB
                                        .addNotification(notificationModel)
                                        .then((value) => notificationManager
                                            .showDietNotificationOnce(
                                                num.parse(recurrentNotifId),
                                                "Hey It's time to take ${newReminder.dietName}",
                                                "Click to open",
                                                currentDateBeingScheduledFor));
                                  }
                                }
                                // switch (model.selectedFreq) {
                                //   case 'Daily':
                                //     notificationManager.showDietNotificationDaily(
                                //         num.parse(notifId),
                                //         "Hey It's Time to Go For ${newReminder.dietName}",
                                //         "For ${model.minDaily} minutes",
                                //         model.getDateTime());
                                //     break;
                                //   case 'Once Every Week':
                                //     setWeeklyNotification(
                                //         newReminder, model.selectedDayName);
                                //     break;
                                //   case 'Twice Every Week':
                                //     setWeeklyNotification(
                                //         newReminder, model.selectedDayName);
                                //     setWeeklyNotification(
                                //         newReminder, model.selectedDayName2);
                                //     break;
                                //   case 'Thrice Every Week':
                                //     setWeeklyNotification(
                                //         newReminder, model.selectedDayName);
                                //     setWeeklyNotification(
                                //         newReminder, model.selectedDayName2);
                                //     setWeeklyNotification(
                                //         newReminder, model.selectedDayName3);
                                //     break;
                                //   case 'Four Times Weekly':
                                //     setWeeklyNotification(
                                //         newReminder, model.selectedDayName);
                                //     setWeeklyNotification(
                                //         newReminder, model.selectedDayName2);
                                //     setWeeklyNotification(
                                //         newReminder, model.selectedDayName3);
                                //     setWeeklyNotification(
                                //         newReminder, model.selectedDayName4);
                                //     break;
                                // }

                                Navigator.popAndPushNamed(
                                    context, RouteNames.dietScheduleScreen);
                              }
                            }),
                      )
                    ],
                  ),
                )),
          ),
        ));
  }

  Text _title(BuildContext context, String text) =>
      Text(text, style: _titleStyle(context));

  TextField _textField(BuildContext context, FocusNode focusNode, int maxLines,
          int maxLenghth, String hint, TextEditingController controller) =>
      TextField(
        controller: controller,
        maxLength: maxLenghth,
        style: TextStyle(color: Theme.of(context).primaryColorDark),
        maxLines: maxLines,
        focusNode: focusNode,
        decoration: InputDecoration(
            hintText: hint ?? '',
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Config.xMargin(context, 3.2)),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColorDark,
                    style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Config.xMargin(context, 3.2)),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColorDark,
                    style: BorderStyle.solid))),
      );

  SizedBox _verticalSpace(BuildContext context) => SizedBox(
        height: Config.yMargin(context, 2.2),
      );

  TextStyle _titleStyle(BuildContext context) => TextStyle(
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.w600,
      fontSize: Config.xMargin(context, 5.55));

  FlatButton _deleteButton(BuildContext context) => FlatButton(
      splashColor: Colors.redAccent,
      color: Theme.of(context).backgroundColor,
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.red,
            size: Config.xMargin(context, 4.95),
          ),
          Text('Delete',
              style: TextStyle(
                color: Colors.red,
                fontSize: Config.textSize(context, 4.95),
              ))
        ],
      ));
}

// ///Custom FoodCard widget to keep things modular
// class FoodCard extends StatelessWidget {
//   final FoodClass foodClass;
//   final bool isSelected;

//   const FoodCard({Key key, this.foodClass, this.isSelected}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Padding(
//       padding: EdgeInsets.only(
//           left: Config.xMargin(context, 3),
//           right: Config.xMargin(context, 3),
//           bottom: Config.yMargin(context, 2)),
//       child: Container(
//         alignment: Alignment.center,
//         width: width * .45,
//         height: height * .3,
//         decoration: BoxDecoration(
//             color: isSelected
//                 ? Theme.of(context).highlightColor.withOpacity(.5)
//                 : Theme.of(context).primaryColorLight,
//             boxShadow: [
//               BoxShadow(
//                   offset: Offset(-1, 1),
//                   color: Theme.of(context).primaryColorDark.withOpacity(.3),
//                   blurRadius: 5,
//                   spreadRadius: 0)
//             ]),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Image.asset(foodClass.image),
//             Text(foodClass.name,
//                 style: TextStyle(
//                     color: isSelected
//                         ? Theme.of(context).primaryColorDark
//                         : Theme.of(context).hintColor,
//                     fontSize: Config.textSize(context, 4.8)))
//           ],
//         ),
//       ),
//     );
//   }
// }
