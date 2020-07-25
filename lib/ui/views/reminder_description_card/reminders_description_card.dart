import 'package:MedBuzz/core/database/notification_data.dart';
import 'package:MedBuzz/ui/views/reminder_description_card/reminder_description_card_model.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class RemindersDescriptionCard extends StatefulWidget {
  final double height;
  final double width;

  final model;
  RemindersDescriptionCard({
    Key key,
    this.height,
    this.width,
    this.model,
  }) : super(key: key);

  @override
  _RemindersDescriptionCardState createState() =>
      _RemindersDescriptionCardState();
}

class _RemindersDescriptionCardState extends State<RemindersDescriptionCard> {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<ReminderDescriptionCardModel>(context);
    var notificationDB = Provider.of<NotificationData>(context);
    notificationDB.getNotifications();
    // final double boxHeight = MediaQuery.of(context).size.height;
    // initializeDateFormatting();
    int progress = model.getCompletedPoints(widget.model, notificationDB);
    int total = model.getTotalPoints(widget.model, notificationDB);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Config.yMargin(context, 1.5)),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: Config.xMargin(context, 2)),
          width: widget.width,
          height: widget.height * .2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Config.xMargin(context, 6)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColorLight,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: Config.yMargin(context, 1)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //circle avatar for reminder image
                    CircleAvatar(
                      child: Image.asset(
                        model.getImage(widget.model),
                        fit: BoxFit.cover,
                      ),
                      radius: Config.xMargin(context, 5.55),
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(.9),
                    ),
                    SizedBox(width: Config.xMargin(context, 4)),
                    //vertical divider
                    Container(
                      color: Theme.of(context).primaryColorDark.withOpacity(.5),
                      height: widget.height * 0.07,
                      width: widget.width * 0.001,
                      child: VerticalDivider(),
                    ),
                    SizedBox(width: Config.xMargin(context, 4)),
                    //section for reminder name, time frame, date and time, and points earned
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Text(
                            model.getReminderName(widget.model),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.bold,
                                fontSize: Config.textSize(context, 5)),
                          ),
                        ),
                        SizedBox(height: Config.yMargin(context, 1)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Total points earned:',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: Config.textSize(context, 3.85)),
                            ),
                            SizedBox(width: Config.xMargin(context, 1.5)),
                            Text(
                              '$progress/$total',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Config.textSize(context, 3.85)),
                            ),
                          ],
                        ),
                        SizedBox(height: Config.yMargin(context, .9)),
                        Row(
                          children: <Widget>[
                            //text widget for time
                            Text(
                                DateFormat('jm').format(widget.model.dateTime)),
                            SizedBox(width: Config.xMargin(context, 1)),
                            //Text widget for date
                            Text(DateFormat('E d MMMM, y')
                                .format(widget.model.dateTime))
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: Config.xMargin(context, 10)),
                    //share button
                    GestureDetector(
                      onTap: () {
                        Share.share(
                            'I successfully gained $progress/$total points for ${model.getReminderName(widget.model)} this week',
                            subject: 'Medbuzz Progress Report');
                      },
                      child: Container(
                          child: Column(children: <Widget>[
                        Icon(
                          Icons.share,
                          color: Theme.of(context).primaryColor,
                          size: Config.xMargin(context, 8.33),
                        ),
                        Text('Share',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: Config.textSize(context, 3.85)))
                      ])),
                    ),

                    //share section
                  ],
                ),
                SizedBox(height: Config.yMargin(context, 1)),
                Divider(
                  color: Theme.of(context).primaryColorDark.withOpacity(.5),
                  endIndent: 10,
                  indent: 10,
                ),
                SizedBox(height: Config.yMargin(context, 1.5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RowButton(
                        iconColor: Colors.red,
                        text:
                            widget.model.isSkipped == true ? 'Skipped' : "Skip",
                        icon: Icons.clear,
                        onPressed: () {
                          //only skip if not already skipped
                          // print('jj');
                          widget.model.isSkipped == false
                              ? notificationDB.handleNotification(
                                  widget.model, false)
                              : null;
                        }),
                    RowButton(
                        iconColor: Colors.green,
                        text:
                            widget.model.isDone == true ? 'Completed' : "Done",
                        icon: Icons.check,
                        onPressed: () {
                          //only complete when not completed
                          widget.model.isDone == false
                              ? notificationDB.handleNotification(
                                  widget.model, true)
                              : null;
                        }),
                  ],
                )
              ])),
    );
  }
}

class RowButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onPressed;
  final Color iconColor;
  final bool isColumn;

  const RowButton(
      {Key key,
      this.icon,
      this.text,
      this.onPressed,
      this.iconColor,
      this.isColumn = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          child: isColumn
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(icon,
                        color: iconColor, size: Config.xMargin(context, 5)),
                    SizedBox(width: Config.yMargin(context, 1)),
                    Text(text,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.xMargin(context, 3.85)))
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icon,
                        color: iconColor, size: Config.xMargin(context, 5)),
                    SizedBox(width: Config.xMargin(context, 2)),
                    Text(text,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.xMargin(context, 3.85)))
                  ],
                )),
    );
  }
}

class IntentPopUp extends StatelessWidget {
  //function that is executed when user taps Yes
  final Function onPressed;

  const IntentPopUp({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: height * .35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Config.xMargin(context, 3))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Are you sure you want to skip this activity?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: Config.xMargin(context, 5.55)),
            ),
            SizedBox(height: Config.yMargin(context, 2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RowButton(
                    isColumn: true,
                    iconColor: Colors.red,
                    text: "No",
                    icon: Icons.clear,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                RowButton(
                    isColumn: true,
                    iconColor: Colors.green,
                    text: "Yes",
                    icon: Icons.check,
                    onPressed: onPressed),
              ],
            )
          ],
        ));
  }
}
