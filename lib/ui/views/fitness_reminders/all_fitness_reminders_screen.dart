import 'dart:async';

import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/fitness_reminder.dart';
import 'package:MedBuzz/core/models/fitness_reminder_model/fitness_reminder.dart';
import 'package:MedBuzz/core/notifications/fitness_notification_manager.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/all_fitness_reminders_model.dart';
import 'package:MedBuzz/ui/widget/scrollable_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/constants/route_names.dart';
import '../../../core/database/fitness_reminder.dart';
import 'single_fitness_screen.dart';

class FitnessSchedulesScreen extends StatefulWidget {
  FitnessSchedulesScreen({this.payload});
  final String payload;
  @override
  _FitnessSchedulesScreenState createState() => _FitnessSchedulesScreenState();
}

class _FitnessSchedulesScreenState extends State<FitnessSchedulesScreen> {
  final ScrollController controller = ScrollController();

  final ItemScrollController itemScrollController = ItemScrollController();

  final FitnessNotificationManager notificationManager =
      FitnessNotificationManager();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset < 120) {
        Provider.of<FitnessSchedulesModel>(context).updateVisibility(true);
      } else {
        Provider.of<FitnessSchedulesModel>(context).updateVisibility(false);
      }
    });

    Future.delayed(Duration.zero, () {
      print(Provider.of<FitnessReminderCRUD>(context).fitnessReminder);
    });

    notificationManager.initNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Some sweet magic to animate FAB
    //This makes the FAB disappear as you scroll down

    Provider.of<FitnessReminderCRUD>(context).getReminders();

    var model = Provider.of<FitnessSchedulesModel>(context);
    var fitnessDB = Provider.of<FitnessReminderCRUD>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fitnessDB.updateAvailableFitnessReminders(fitnessDB.fitnessReminder);
    });
    //MediaQueries for responsiveness
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: AnimatedOpacity(
        duration: Duration(milliseconds: 800),
        opacity: model.isVisible ? 1 : 0,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 800),
          height: model.isVisible ? Config.yMargin(context, 10) : 0,
          child: Container(
            margin: EdgeInsets.only(
                bottom: Config.yMargin(context, 2),
                right: Config.xMargin(context, 4)),
            child: SizedBox(
              height: height * 0.08,
              width: height * 0.08,
              child: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColorLight,
                  size: Config.xMargin(context, 9),
                ),
                backgroundColor: Theme.of(context).buttonColor,
                splashColor: Theme.of(context).buttonColor.withOpacity(.9),
                //Navigate to fitness reminder creation screen
                onPressed: () {
                  Navigator.pushNamed(
                      context, RouteNames.fitnessDescriptionScreen);
                },
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Fitness',
            style: TextStyle(color: Theme.of(context).primaryColorDark)),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace,
              color: Theme.of(context).primaryColorDark),

          //Function to navigate to previous screen or home screen (as the case maybe) goes here
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.homePage);
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        physics: BouncingScrollPhysics(),
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: Config.xMargin(context, 3),
                vertical: Config.yMargin(context, 2)),
            child: Column(
              children: <Widget>[
                Container(
                  height: height * .3,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: Config.yMargin(context, 23),
                          child: ScrollableCalendar(
                            model: model,
                            useButtonColor: true,
                            hideDivider: true,
                          )),
                      //Text widget to display current date in MONTH Year format
                      Text(
                        model.currentMonth,
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: Config.textSize(context, 6)),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Config.yMargin(context, 5)),

//                Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text(
//                      'Fitness',
//                      style: TextStyle(
//                        fontSize: Config.textSize(context, 5),
//                        fontWeight: FontWeight.w600,
//                      ),
//                    ),
//                    SizedBox(height: height * 0.02),
//                    Visibility(
//                        visible:
//                            fitnessDB.fitnessRemindersBasedOnDateTime.length ==
//                                0,
//                        child: Text('No fitness reminders set yet')),
//                    for (var fitnessReminder
//                        in fitnessDB.fitnessRemindersBasedOnDateTime)
//                      FitnessCard(
//                        height: height,
//                        width: width,
//                        fitnessReminder: fitnessReminder,
//                        selectedFreq: fitnessReminder.fitnessfreq,
//                        fitnessType: fitnessReminder.index == 0
//                            ? 'images/jogging.png'
//                            : fitnessReminder.index == 1
//                                ? "images/swimming.png"
//                                : fitnessReminder.index == 2
//                                    ? "images/cycling.png"
//                                    : fitnessReminder.index == 3
//                                        ? "images/volleyball.png"
//                                        : fitnessReminder.index == 4
//                                            ? "images/tabletennis.png"
//                                            : fitnessReminder.index == 5
//                                                ? "images/football.png"
//                                                : fitnessReminder.index == 6
//                                                    ? "images/badminton.png"
//                                                    : "images/basketball.png",
//                        startDate: fitnessReminder.startDate.toString(),
//                      ),
//                  ],
//                ),
                //Here the already saved reminders will be loaded dynamically
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     model.selectedTime == null ? '' : model.selectedTime,
                //     style: TextStyle(
                //         letterSpacing: 1.5,
                //         fontSize: Config.textSize(context, 6)),
                //   ),
                // ),

                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingleFitnessScreen(
                              rem: fitnessDB.fitnessReminder[index],
                            ),
                          ),
                        );
                      },
                      child: FitnessCard(
                        fitnessReminder: fitnessDB.fitnessReminder[index],
                        fitnessType:
                            fitnessDB.fitnessReminder[index].fitnesstype,
                        startDate: fitnessDB.fitnessReminder[index].startDate
                            .toString(),
                        endDate:
                            fitnessDB.fitnessReminder[index].endDate.toString(),
                        selectedFreq:
                            fitnessDB.fitnessReminder[index].fitnessfreq,
                      ),
                    );
                  },
                  itemCount: fitnessDB.fitnessReminder.length,
                )
              ],
            )),
      ),
    );
  }
}

class FitnessCard extends StatefulWidget {
  final double height;
  final double width;
  final String fitnessType;
  final String activityType;
  final String startDate;
  final String endDate;
  final String selectedFreq;
//  final String activityType;
//  final
  final FitnessReminder fitnessReminder;

  FitnessCard(
      {this.height,
      this.width,
      this.fitnessType,
      this.activityType,
      this.startDate,
      this.endDate,
      this.selectedFreq,
      this.fitnessReminder});

  @override
  _FitnessCardState createState() => _FitnessCardState();
}

class _FitnessCardState extends State<FitnessCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var fitnessModel = Provider.of<FitnessReminderCRUD>(context);

    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          print([
            fitnessModel.updateDescription(widget.fitnessReminder.description),
            fitnessModel
                .updateSelectedActivityType(widget.fitnessReminder.fitnesstype),
            fitnessModel.updateStartDate(widget.fitnessReminder.startDate),
            fitnessModel.updateEndDate(widget.fitnessReminder.endDate),
            fitnessModel.updateActivityTime(fitnessModel
                .convertTimeBack(widget.fitnessReminder.activityTime)),
            fitnessModel.updateSelectedIndex(widget.fitnessReminder.index),
            fitnessModel.updateFreq(widget.fitnessReminder.fitnessfreq),
            fitnessModel.updateMinDaily(widget.fitnessReminder.minsperday),
            fitnessModel.updateID(widget.fitnessReminder.id)
//            fitnessModel.updateIndex(widget.fitnessReminder.index)
          ]);

//          FitnessReminder reminder = FitnessReminder(
//            id: fitnessModel.id,
//            fitnessfreq: fitnessModel.selectedFreq,
//            fitnesstype: fitnessModel.fitnessType[widget.fitnessReminder.index],
//            minsperday: fitnessModel.minDaily,
//          );

          Navigator.pushNamed(context, RouteNames.singleFitnessScreen);
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              Text(
                fitnessModel
                    .convertTimeBack(widget.fitnessReminder.activityTime)
                    .format(context)
                    .toString(),
              ),
              SizedBox(height: height * 0.02),
              Container(
                  width: width,
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.xMargin(context, 4),
                      vertical: Config.yMargin(context, 2)),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius:
                        BorderRadius.circular(Config.xMargin(context, 5)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                right: Config.xMargin(context, 7),
                              ),
                              child: Image.asset(fitnessModel
                                  .activityType[widget.fitnessReminder.index])),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${fitnessModel.fitnessType[widget.fitnessReminder.index]} ${widget.selectedFreq}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: height * 0.005),
                              Text(
                                '${widget.startDate}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Config.yMargin(context, 1),
                        width: double.infinity,
                      ),
                      Visibility(
                        visible: false,
                        child: Divider(
                          color: Theme.of(context).primaryColorDark,
                          height: height * 0.02,
                          endIndent: 10.0,
                        ),
                      ),
                      // Visibility(
                      //     visible: isSelected,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       mainAxisSize: MainAxisSize.max,
                      //       children: <Widget>[
                      //         Expanded(child: flatButton('View')),
                      //         // Expanded(child: flatButton('Skip')),
                      //         // Expanded(child: flatButton('Reset'))
                      //       ],
                      //     ))
                    ],
                  )),
            ]),
      ),
    );
  }
}

//class FitnessCards extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    double height = MediaQuery.of(context).size.height;
//    double width = MediaQuery.of(context).size.width;
//    // FitnessNotificationManager fitnessNotificationManager =
//    //     FitnessNotificationManager();
//    var fitnessModel = Provider.of<FitnessReminderCRUD>(context);
//    return Consumer<FitnessReminderCRUD>(builder: (context, data, child) {
//      return Container(
//        width: width,
//        height: height * .80,
//        child: SingleChildScrollView(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: data.fitnessReminder.map((e) {
//              // getNotification() {
//              //   final now = new DateTime.now();
//              //   final time = DateTime(now.year, now.month, now.day,
//              //       e.activityTime[0], e.activityTime[1]);
//              //   if (DateTime(now.year, now.month, now.day, now.hour, now.minute)
//              //           .compareTo(time) ==
//              //       0) {
//              //     fitnessNotificationManager.showFitnessNotificationOnce(
//              //         0,
//              //         "It's time to go ${e.name}",
//              //         "For ${e.minsperday} minutes");
//              //   }
//              // }
//
//              // Timer.periodic(
//              //   Duration(seconds: 40),
//              //   (Timer timer) {
//              //     print('Available Reminders Check!');
//              //     getNotification();
//              //   },
//              // );
//
//              return InkWell(
//                splashColor: Theme.of(context).backgroundColor,
//                onTap: () {
//                  //Navigate to screen with single reminder i.e the on user clicked on
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SingleFitnessScreen(
//                                data: e,
//                              )));
//                },
//                child: Column(
//                  children: <Widget>[
//                    Divider(
//                        thickness: 0.7,
//                        color:
//                            Theme.of(context).primaryColorDark.withOpacity(.4),
//                        indent: Config.xMargin(context, 0.5),
//                        endIndent: Config.xMargin(context, 2.5)),
//
//                    SizedBox(height: Config.yMargin(context, .5)),
//                    Container(
//                      width: width,
//                      height: height * .22,
//                      decoration: BoxDecoration(
//                        borderRadius:
//                            BorderRadius.circular(Config.xMargin(context, 8)),
//                      ),
//                      child: e.fitnesstype == '0'
//                          ? image('images/cycle.png')
//                          : e.fitnesstype == '1'
//                              ? image('images/sprint.png')
//                              : image('images/swim.png'),
//                    ),
//                    SizedBox(height: Config.yMargin(context, 2)),
//                    //Type of fitness exercise goes here
//                    Text(e.description,
//                        style: TextStyle(
//                            fontSize: Config.textSize(context, 6),
//                            fontWeight: FontWeight.w500,
//                            color: Theme.of(context).primaryColor)),
//                    SizedBox(height: Config.yMargin(context, 1)),
//                    Text(e.minsperday.toString() + ' minutes daily',
//                        style: TextStyle(
//                            fontSize: Config.textSize(context, 4.5),
//                            fontWeight: FontWeight.w400,
//                            color: Theme.of(context).primaryColorDark)),
//                  ],
//                ),
//              );
//            }).toList(),
//          ),
//        ),
//      );
//    });
//  }
//
//  image(String image) {
//    return Image(
//      image: AssetImage(image),
//      fit: BoxFit.contain,
//    );
//  }
//}

// class CustomDateButton extends StatelessWidget {
//   final DateTime date;

//   CustomDateButton({this.date});
//   @override
//   Widget build(BuildContext context) {
//     var model = Provider.of<FitnessSchedulesModel>(context, listen: false);
//     return Container(
//       margin: EdgeInsets.only(right: Config.xMargin(context, 3)),
//       width: Config.xMargin(context, 19),
//       alignment: Alignment.center,
//       child: FlatButton(
//         onPressed: () => model.changeDay(date),

//         //functionality for finding out if selected date (defaults to present day) equals the date passed in the constructor
//         //I'm using this to determine the color of the container
//         color: model.getButtonColor(context, date),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(Config.xMargin(context, 11)),
//         ),
//         child: Container(
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               //Day in integer goes here
//               Text(
//                 '${date.day}',
//                 style: TextStyle(
//                     fontSize: Config.textSize(context, 8),
//                     fontWeight: FontWeight.w600,
//                     color: model.getTextColor(context, date)),
//               ),

//               SizedBox(
//                 height: Config.yMargin(context, 3),
//               ),

//               //Day in shortened words goes here
//               Text(
//                 model.getWeekday(date),
//                 style: TextStyle(
//                     fontSize: Config.textSize(context, 4.8),
//                     fontWeight: FontWeight.w500,
//                     color: model.getTextColor(context, date)),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
