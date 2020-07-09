import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/diet_reminderDB.dart';
import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:MedBuzz/core/notifications/diet_notification_manager.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/diet_reminders/diet_reminders_model.dart';
import 'package:MedBuzz/ui/widget/appBar.dart';
import 'package:MedBuzz/ui/widget/scrollable_calendar.dart';
import 'package:MedBuzz/ui/widget/time_wheel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleDietReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(body: AddDietReminderScreen());
}

class AddDietReminderScreen extends StatelessWidget {
  //this variable will determine if this screen will be for
  //adding or editing diet reminders
  final bool isEdit;
  final notificationManager = DietNotificationManager();

  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController mealDescController = TextEditingController();

  // FocusNode objects for eacj textfield used to disable focus when user isn't typing
  final FocusNode mealNameFocusNode = FocusNode();
  final FocusNode mealDescFocusNode = FocusNode();

  AddDietReminderScreen({Key key, this.isEdit = false}) : super(key: key);
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
    var db = Provider.of<DietReminderDB>(context);
    var model = Provider.of<DietReminderModel>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        //Extracted appBar to widgets folder
        appBar: appBar(
            context: context,
            title: isEdit ? 'Edit your diet' : 'Add diet',
            actions: isEdit ? [_deleteButton(context)] : null),
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
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                            isExpanded: false,
                            icon: Icon(Icons.expand_more),
                            // here sets the value to the selected month and if null, it defaults to the present date month from DateTime.now()
                            value: model.currentMonth,
                            hint: Text('Month',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Config.textSize(context, 4.8),
                                    color: Theme.of(context).hintColor)),
                            items: model.months
                                .map((month) => DropdownMenuItem(
                                      child: Container(
                                        child: Text(
                                          month,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                                  Config.textSize(context, 4.8),
                                              color:
                                                  Theme.of(context).hintColor),
                                        ),
                                      ),
                                      value: month,
                                    ))
                                .toList(),
                            onChanged: (val) {
                              model.updateSelectedMonth(val);
                              unFocus();
                            }),
                      ),
                      SizedBox(height: Config.yMargin(context, 3)),
                      Container(
                          height: Config.yMargin(context, 19),
                          child: ScrollableCalendar(
                            model: model,
                            useButtonColor: true,
                            hideDivider: true,
                          )),
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
                      SizedBox(height: Config.yMargin(context, 5)),
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
                                                            ? 0
                                                            : Config.xMargin(
                                                                context, 3.88),
                                                        left: model
                                                                .selectedFoodClasses
                                                                .contains(
                                                                    foodClass
                                                                        .name)
                                                            ? 0
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
                            SizedBox(height: Config.yMargin(context, 3.5)),
                            _title(context, 'Meal Description'),
                            _verticalSpace(context),
                            _textField(context, mealDescFocusNode, 6, 100,
                                'Optional description...', mealDescController),
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

                            //Functions to save  reminder to db and schedule notification goes here
                            onPressed: () {
                              if (model
                                      .getDateTime()
                                      .difference(DateTime.now())
                                      .inDays <
                                  0) {
                                showSnackbar(context);
                                return;
                              }
                              if (mealNameController.text.isEmpty) {
                                showSnackbar(context, text: 'Enter meal name');
                                return;
                              }

                              if (model.selectedFoodClasses.length < 1) {
                                showSnackbar(context,
                                    text: 'Select at least one meal category');
                                return;
                              } else {
                                db.addDiet(DietModel(
                                    id: DateTime.now().toString(),
                                    foodClasses: model.selectedFoodClasses,
                                    dietName: mealNameController.text,
                                    description: mealDescController.text ?? '',
                                    startDate: model.getStartDate(),
                                    time: [
                                      num.parse(
                                          model.selectedTime.substring(0, 2)),
                                      num.parse(
                                          model.selectedTime.substring(3, 5))
                                    ]));

                                notificationManager.showDietNotificationOnce(
                                    num.parse(
                                        '${model.getStartDate().year}${model.getStartDate().month}${model.getStartDate().day}${model.selectedTime.substring(0, 2)}${model.selectedTime.substring(3, 5)}'),
                                    'Its time to take your meal',
                                    '${mealNameController.text}',
                                    model.getDateTime());

                                Navigator.pushReplacementNamed(
                                    context, RouteNames.dietScheduleScreen);
                              }
                            },
                            child: Text('Save',
                                style: TextStyle(
                                    fontSize: Config.textSize(context, 5),
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).primaryColorLight))),
                      )
                    ],
                  ),
                )),
          ),
        ));
  }

  void showSnackbar(BuildContext context,
      {String text: "Reminder can't be set in the past"}) {
    SnackBar snackBar = SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
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
