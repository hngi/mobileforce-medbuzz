import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/medication_reminders/all_medications_reminder_model.dart';
import 'package:MedBuzz/ui/widget/scroll_calender_med.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicationScreen extends StatefulWidget {
  @override
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  @override
  void initState() {
    super.initState();
    //Some sweet magic to animate FAB
    //This makes the FAB disappear as you scroll down
    controller.addListener(() {
      if (controller.offset < 120) {
        Provider.of<MedicationData>(context).updateVisibility(true);
      } else {
        Provider.of<MedicationData>(context).updateVisibility(false);
      }
    });

    // // SharedPreferences prefs = await SharedPreferences.getInstance();
    // // //Check if features introduction have been viewed before
    // // bool value = await haveViewedIntroduction().then((value) => value);
    // // if (!value) {
    // FeatureDiscovery.discoverFeatures(
    //   context,
    //   const <String>{'feature_1', 'feature_2', 'feature_3'}, //Add Others
    // );
    // //   prefs.setBool('haveViewed', true);
    // // }
  }

  // Future<bool> haveViewedIntroduction() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool value = prefs.getBool('haveViewed');

  //   return value;
  // }

  bool isVisible = true;
  bool isExpanded = false;
  ScrollController controller = ScrollController();
  var _color = Colors.grey;
  var _height = 80;
  @override
  Widget build(BuildContext context) {
    var medReminder = Provider.of<MedicationData>(context);
    medReminder.getMedicationReminder();
    var model = Provider.of<MedicationData>(context);
    var medsModel = Provider.of<MedicationsSchedulesModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      medsModel
          .updateAvailableMedicationReminders(medReminder.medicationReminder);
    });
    //MediaQueries for responsiveness
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: model.isVisible ? 1 : 0,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: Visibility(
            visible: model.isVisible,
            child: Container(
              margin: EdgeInsets.only(
                  bottom: Config.yMargin(context, 2),
                  right: Config.xMargin(context, 4)),
              child: SizedBox(
                height: height * 0.08,
                width: height * 0.08,
                child: FloatingActionButton(
                    child: DescribedFeatureOverlay(
                      tapTarget: Icon(
                        Icons.add,
                        color: Colors.grey[800],
                      ),
                      featureId: "feature_1",
                      title: Text("Add Medication"),
                      description: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "You can click here to create a new medication schedule"),
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          SizedBox(height: Config.yMargin(context, 0.5)),
                          Text(
                              "You can also click on added Medications to expand card and view details"),
                          SizedBox(height: Config.yMargin(context, 0.5)),
                          SizedBox(
                              width: Config.xMargin(context, 40),
                              child: Image.asset('images/para_two.png')),
                        ],
                      ),
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColorLight,
                        size: Config.xMargin(context, 7),
                      ),
                    ),
                    backgroundColor: Theme.of(context).buttonColor,
                    splashColor: Theme.of(context).buttonColor.withOpacity(.9),
                    //Navigate to fitness reminder creation screen
                    onPressed: () {
                      final medModel = Provider.of<MedicationData>(context);
                      medModel.newMedicine(context);
                    }),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'My Medications',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).primaryColorDark),
        ),
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace,
                color: Theme.of(context).primaryColorDark),

            //Function to navigate to previous screen or home screen (as the case maybe) goes here
            onPressed: () {
              Navigator.popAndPushNamed(context, RouteNames.homePage);
            }),
      ),
      body: SingleChildScrollView(
        controller: controller,
        physics: BouncingScrollPhysics(),
        child: DescribedFeatureOverlay(
          tapTarget: Text("Next", style: TextStyle(color: Colors.grey[800])),
          featureId: "feature_2",
          title: Text("View Medication for different days"),
          description: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Select days from the calendar to View medications for the day"),
              SizedBox(height: Config.yMargin(context, 3)),
              SizedBox(
                  height: Config.yMargin(context, 19),
                  child: Image.asset('images/cal.png')),
              SizedBox(height: Config.yMargin(context, 3)),
            ],
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(Config.xMargin(context, 3),
                Config.yMargin(context, 2), Config.xMargin(context, 3), 0),
            child: Column(
              children: <Widget>[
                Container(
                  //height: height * .27,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //ListView to display all dates with entries in the DB
                      Container(
                          height: Config.yMargin(context, 18),
                          child: ScrollableCalendar(
                            model: medsModel,
                            useButtonColor: true,
                            hideDivider: true,
                          )),
                      SizedBox(height: Config.yMargin(context, 2)),
                      //Text widget to display current date in MONTH Year format
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  medsModel.selectedMonth,
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: Config.textSize(context, 4)),
                                ),
                                DescribedFeatureOverlay(
                                  tapTarget: Text("Get Started",
                                      style:
                                          TextStyle(color: Colors.grey[800])),
                                  featureId: "feature_3",
                                  title: Text("View Medication History"),
                                  description: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Completed Medications automatically deletes itself, 1hour after it expires. but you can review past Medications by clicking on \"View History.\" "),
                                      SizedBox(
                                          height: Config.yMargin(context, 3)),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    //Navigate to history screen
                                    onTap: () {
                                      Navigator.pushReplacementNamed(context,
                                          RouteNames.medicationHistoryPage);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey,
                                          )),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            Config.xMargin(context, 1)),
                                        child: Text("View History"),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                          SizedBox(height: Config.yMargin(context, 2)),
                          Text(
                            'Medications',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Config.yMargin(context, 1)),
                //Here the already saved reminders will be loaded dynamically
                Visibility(
                  visible: medsModel.medicationReminderBasedOnDateTime.isEmpty,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Config.yMargin(context, 20.0)),
                    child: Container(
                      child: Text('No Medication Reminder Set for this Date'),
                    ),
                  ),
                ),
                for (var medicationReminder
                    in medsModel.medicationReminderBasedOnDateTime)
                  MedicationCard(
                    values: medicationReminder,
                    drugName: medicationReminder.drugName,
                    drugType: medicationReminder.drugType == 'Injection'
                        ? "images/injection.png"
                        : medicationReminder.drugType == 'Tablets'
                            ? "images/tablets.png"
                            : medicationReminder.drugType == 'Drops'
                                ? "images/drops.png"
                                : medicationReminder.drugType == 'Pills'
                                    ? "images/pills.png"
                                    : medicationReminder.drugType == 'Ointment'
                                        ? "images/ointment.png"
                                        : medicationReminder.drugType == 'Syrup'
                                            ? "images/syrup.png"
                                            : "images/inhaler.png",
                    time: medicationReminder.firstTime.toString(),
                    dosage: medicationReminder.dosage,
                    selectedFreq: medicationReminder.frequency,
                  )
                // Container(
                //   margin: EdgeInsets.only(bottom: Config.yMargin(context, 2)),
                //   child: ListView.builder(
                //     scrollDirection: Axis.vertical,
                //     physics: NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemBuilder: (context, index) {
                //       return MedicationCard(
                //         values: model.medicationReminder[index],
                //         drugName: model.medicationReminder[index].drugName,
                //         drugType: model.medicationReminder[index].drugType ==
                //                 'Injection'
                //             ? "images/injection.png"
                //             : model.medicationReminder[index].drugType ==
                //                     'Tablets'
                //                 ? "images/tablets.png"
                //                 : model.medicationReminder[index].drugType ==
                //                         'Drops'
                //                     ? "images/drops.png"
                //                     : model.medicationReminder[index]
                //                                 .drugType ==
                //                             'Pills'
                //                         ? "images/pills.png"
                //                         : model.medicationReminder[index]
                //                                     .drugType ==
                //                                 'Ointment'
                //                             ? "images/ointment.png"
                //                             : model.medicationReminder[index]
                //                                         .drugType ==
                //                                     'Syrup'
                //                                 ? "images/syrup.png"
                //                                 : "images/inhaler.png",
                //         time: model.medicationReminder[index].firstTime
                //             .toString(),
                //         dosage: model.medicationReminder[index].dosage,
                //         selectedFreq: model.medicationReminder[index].frequency,
                //       );
                //     },
                //     itemCount: model.medicationReminder.length,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDateButton extends StatelessWidget {
  final DateTime date;

  CustomDateButton({this.date});
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MedicationData>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(right: Config.xMargin(context, 3)),
      width: Config.xMargin(context, 15.5),
      child: FlatButton(
        onPressed: () => model.changeDay(date),

        //functionality for finding out if today equals the date passed in the constructor
        //I'm using this to determine the color of the container
        color: model.getButtonColor(context, date),
        padding: EdgeInsets.only(right: Config.xMargin(context, 3)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Config.xMargin(context, 10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Day in integer goes here
            Text(
              '${date.day}',
              style: TextStyle(
                  fontSize: Config.textSize(context, 10),
                  fontWeight: FontWeight.bold,
                  color: model.getTextColor(context, date)),
            ),

            SizedBox(
              height: Config.yMargin(context, 4),
            ),

            //Day in shortened words goes here
            //functionality fot this can be extracted and moved to the view model
            Text(
              model.getWeekday(date),
              style: TextStyle(
                  fontSize: Config.textSize(context, 4.8),
                  fontWeight: FontWeight.w600,
                  color: model.getTextColor(context, date)),
            )
          ],
        ),
      ),
    );
  }
}

class MedicationCard extends StatefulWidget {
  final double height;
  final double width;
  final String drugName;
  final String drugType;
  final String time;
  final int dosage;
  final String selectedFreq;
  final MedicationReminder values;

  MedicationCard(
      {this.values,
      this.drugName,
      this.drugType,
      this.time,
      this.height,
      this.width,
      this.dosage,
      this.selectedFreq});

  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final medModel = Provider.of<MedicationData>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
//    print(height);
//    print(width);
    return GestureDetector(
      //Navigate to screen with single reminder i.e the on user clicked on
      onTap: () {
        setState(() => isSelected = !isSelected);
      },

      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //SizedBox(height: height * 0.02),
            AnimatedContainer(
                duration: Duration(microseconds: 100),
                width: width,
                padding: EdgeInsets.symmetric(
                    horizontal: Config.xMargin(context, 3),
                    vertical: Config.yMargin(context, 1)),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                  borderRadius:
                      BorderRadius.circular(Config.xMargin(context, 5)),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          medModel.images[int.parse(widget.values.index)],
//                            color: Theme.of(context).primaryColorLight,
                          width: width * 0.2,
                          height: height * 0.1,
                        ),
                        SizedBox(
                          width: Config.xMargin(context, 8.5),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.values.drugName,
                              style: TextStyle(
                                  color: isSelected
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: height * 0.005),
                            Text(
                              '${widget.dosage} - ${widget.selectedFreq} per day',
                              style: TextStyle(
                                  color: isSelected
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColorDark),
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
                      visible: isSelected,
                      child: Column(
                        children: <Widget>[
                          Divider(
                            color: Theme.of(context).primaryColorLight,
                            height: height * 0.02,
//indent: 50.0,
                            // endIndent: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  var medModel =
                                      Provider.of<MedicationData>(context);
                                  print(
                                      '----All Medication Reminder info ------');
                                  medModel.updateSelectedDrugType(
                                      widget.values.drugType);
                                  medModel
                                      .updateDrugName(widget.values.drugName);
                                  print("id = " +
                                      medModel.updateId(widget.values.id));
                                  medModel.updateDosage(widget.values.dosage);
                                  medModel
                                      .updateStartDate(widget.values.startAt);
                                  medModel.updateEndDate(widget.values.endAt);
                                  print(medModel
                                      .updateFreq(widget.values.frequency));
                                  print(medModel.updateDescription(
                                      widget.values.description));

                                  if (medModel.selectedFreq == 'Once') {
                                    print(medModel.updateFirstTime(
                                        medModel.convertTimeBack(
                                            widget.values.firstTime)));
                                  } else if (medModel.selectedFreq == 'Twice') {
                                    print(medModel.updateFirstTime(
                                        medModel.convertTimeBack(
                                            widget.values.firstTime)));
                                    print(medModel.updateSecondTime(
                                        medModel.convertTimeBack(
                                            widget.values.secondTime)));
                                  } else if (medModel.selectedFreq ==
                                      'Thrice') {
                                    print(medModel.updateFirstTime(
                                        medModel.convertTimeBack(
                                            widget.values.firstTime)));
                                    print(medModel.updateSecondTime(
                                        medModel.convertTimeBack(
                                            widget.values.secondTime)));
                                    print(medModel.updateThirdTime(
                                        medModel.convertTimeBack(
                                            widget.values.thirdTime)));
                                  }
                                  print(medModel.updateSelectedIndex(
                                      int.parse(widget.values.index)));

                                  MedicationReminder reminder =
                                      MedicationReminder(
                                          drugName: medModel.drugName,
                                          id: medModel.id,
                                          frequency: medModel.selectedFreq,
                                          firstTime: medModel
                                              .convertTime(medModel.firstTime),
                                          secondTime: medModel.selectedFreq ==
                                                      "Twice" ||
                                                  medModel.selectedFreq ==
                                                      "Thrice"
                                              ? medModel.convertTime(
                                                  medModel.secondTime)
                                              : null,
                                          thirdTime: medModel.selectedFreq ==
                                                  "Thrice"
                                              ? medModel.convertTime(
                                                  medModel.thirdTime)
                                              : null);

                                  medModel.setReminder(reminder);

                                  print('-------------------------------');

                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.medicationView,
                                  );
                                },
                                child: Text(
                                  'View',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Theme.of(context).primaryColorLight
                                          : Theme.of(context).primaryColorDark),
                                ),
                              ),
                              // FlatButton(
                              //   child: Row(
                              //     children: <Widget>[
                              //       Icon(
                              //         Icons.close,
                              //         color: isSelected
                              //             ? Theme.of(context).primaryColorLight
                              //             : Theme.of(context).primaryColorDark,
                              //         size: Config.textSize(context, 3),
                              //       ),
                              //       SizedBox(
                              //         width: Config.xMargin(context, 2),
                              //       ),
                              //       Text(
                              //         'Skip',
                              //         style: TextStyle(
                              //             fontWeight: FontWeight.bold,
                              //             color: isSelected
                              //                 ? Theme.of(context).primaryColorLight
                              //                 : Theme.of(context).primaryColorDark),
                              //       )
                              //     ],
                              //   ),
                              //   onPressed: () {},
                              // ),
                              // FlatButton(
                              //   onPressed: () {},
                              //   child: Row(
                              //     children: <Widget>[
                              //       Icon(
                              //         Icons.done,
                              //         color: isSelected
                              //             ? Theme.of(context).primaryColorLight
                              //             : Theme.of(context).primaryColorDark,
                              //         size: Config.textSize(context, 3),
                              //       ),
                              //       SizedBox(
                              //         width: Config.xMargin(context, 2),
                              //       ),
                              //       Text(
                              //         'Done',
                              //         style: TextStyle(
                              //             fontWeight: FontWeight.bold,
                              //             color: isSelected
                              //                 ? Theme.of(context).primaryColorLight
                              //                 : Theme.of(context).primaryColorDark),
                              //       )
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            SizedBox(height: height * 0.01),
          ]),
    );
  }
}
