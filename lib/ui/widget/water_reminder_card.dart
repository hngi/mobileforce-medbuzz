import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/models/water_reminder_model/water_reminder.dart';

class WaterReminderCard extends StatefulWidget {
  final double height;
  final double width;
  final WaterReminder waterReminder;

  WaterReminderCard(
      {@required this.height,
      @required this.width,
      @required this.waterReminder});
  @override
  _WaterCardState createState() => _WaterCardState();
}

class _WaterCardState extends State<WaterReminderCard> {
  bool isSelected = false;
  bool _skip = false;
  bool _done = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      child: GestureDetector(
        //Navigate to screen with single reminder i.e the on user clicked on
        onTap: () {
          setState(() => isSelected = !isSelected);
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: widget.height * 0.02),
              Text(
                DateFormat.jm().format(widget.waterReminder.dateTime) ??
                    "10:00 AM",
              ),
              SizedBox(height: widget.height * 0.02),
              Container(
                  width: widget.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.xMargin(context, 3),
                      vertical: Config.yMargin(context, 1)),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                    borderRadius:
                        BorderRadius.circular(Config.xMargin(context, 5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 5,
//blurRadius: 2,
//offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              right: Config.xMargin(context, 7),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Image(
                                  image: AssetImage(
                                    'images/bigdrop.png',
                                  ),
                                  height: height * 0.05,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: Config.xMargin(context, 4.5),
                                      top: Config.yMargin(context, 1)),
                                  child: Image(
                                    image: AssetImage('images/smalldrop.png'),
                                    height: height * 0.03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Drink ${widget.waterReminder.ml ?? 150}ml of water',
                                style: TextStyle(
                                    color: isSelected
                                        ? Theme.of(context).primaryColorLight
                                        : Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: widget.height * 0.005),
                              Text(
                                _skip == true
                                    ? 'Skipped'
                                    : _done == true ||
                                            widget.waterReminder.dateTime
                                                .isAfter(DateTime.now())
                                        ? 'Completed'
                                        : 'Upcoming',
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
                        child: Divider(
                          color: Theme.of(context).primaryColorDark,
                          height: widget.height * 0.02,
                          endIndent: 10.0,
                        ),
                      ),
                      Visibility(
                          visible: isSelected,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              flatButton('View'),
                              SizedBox(
                                width: Config.xMargin(context, 3.5),
                              ),
                              flatButton('Skip'),
                              SizedBox(
                                width: Config.xMargin(context, 3.5),
                              ),
                              flatButton('Done')
                            ],
                          ))
                    ],
                  )),
            ]),
      ),
    );
  }

  Widget flatButton(String text) {
    return FlatButton(
      onPressed: () {
        setState(() {
          text == 'Skip' ? _skip = true : _skip = false;
          text == 'Done' ? _done = true : _done = false;
        });
      },
      child: Row(
        children: <Widget>[
          Icon(
            text == 'Skip' ? Icons.close : text == 'Done' ? Icons.check : null,
            size: 15,
            color: Theme.of(context).primaryColorLight,
          ),
          SizedBox(
            width: Config.xMargin(context, 2),
          ),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Config.textSize(context, 3.7),
                color: isSelected
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColorDark),
          ),
        ],
      ),
    );
  }
}
