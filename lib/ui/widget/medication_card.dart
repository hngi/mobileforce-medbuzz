import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/views/medication_reminders/all_medications_reminder_screen.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/ui/views/medication_reminders/medication_reminder_view.dart';

class MedicationCard extends StatefulWidget {
  final String drugName;
  final String drugType;
  final String time;
  final int dosage;
  final String selectedFreq;

  MedicationCard({
    this.drugName,
    this.drugType,
    this.time,
    this.dosage,
    this.selectedFreq,
  });

  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
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
            Text(
              widget.time,
            ),
            SizedBox(height: height * 0.02),
            Container(
                width: width,
                padding: EdgeInsets.symmetric(
                    horizontal: Config.xMargin(context, 3),
                    vertical: Config.yMargin(context, 1)),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).backgroundColor,
                  borderRadius:
                      BorderRadius.circular(Config.xMargin(context, 5)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColorLight,
                      spreadRadius: Config.xMargin(context, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          widget.drugType,
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
                              widget.drugName,
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
                    Divider(
                      color: Theme.of(context).primaryColorLight,
                      height: height * 0.02,
//indent: 50.0,
                      // endIndent: 10.0,
                    ),
                    Visibility(
                      visible: isSelected,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
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
                          FlatButton(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.close,
                                  color: isSelected
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColorDark,
                                  size: Config.textSize(context, 3),
                                ),
                                SizedBox(
                                  width: Config.xMargin(context, 2),
                                ),
                                Text(
                                  'Skip',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Theme.of(context).primaryColorLight
                                          : Theme.of(context).primaryColorDark),
                                )
                              ],
                            ),
                            onPressed: () {},
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.done,
                                  color: isSelected
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColorDark,
                                  size: Config.textSize(context, 3),
                                ),
                                SizedBox(
                                  width: Config.xMargin(context, 2),
                                ),
                                Text(
                                  'Done',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Theme.of(context).primaryColorLight
                                          : Theme.of(context).primaryColorDark),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ]),
    );
  }
}
