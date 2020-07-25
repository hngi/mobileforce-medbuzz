import 'package:MedBuzz/core/database/notification_data.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/badge/badge_screen.dart';
import 'package:MedBuzz/ui/views/badge/badges.dart';
import 'package:MedBuzz/ui/views/reminder_description_card/reminders_description_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_all_reminders_model.dart';

class NewAllReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var model = Provider.of<NewAllReminderModel>(context);
    var notificationDB = Provider.of<NotificationData>(context);
    notificationDB.getNotifications();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(''),
            bottom: TabBar(tabs: <Widget>[
              Text(
                'Reminders',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Theme.of(context).primaryColorLight),
              ),
              Text(
                'Badges',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Theme.of(context).primaryColorLight),
              ),
            ]),
          ),
          body: TabBarView(children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.xMargin(context, 2.77),
                      vertical: Config.yMargin(context, 2)),
                  child: Column(children: <Widget>[
                    //container with custom greeting and some weird ass abacus-looking stats
                    Container(
                      width: width,
                      height: height * .25,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            BorderRadius.circular(Config.xMargin(context, 3)),
                      ),
                      child: Column(children: <Widget>[
                        Row(
                          children: <Widget>[
                            //first column for greeting and some text
                            Container(
                              width: width * .45,
                              height: height * .25,
                              margin: EdgeInsets.only(
                                  left: Config.xMargin(context, 2.77)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    model.getGreeting(context),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: Config.xMargin(context, 5),
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                  ),
                                  SizedBox(height: Config.yMargin(context, 1)),
                                  Text(
                                    model.getUserProgress(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: Config.xMargin(context, 3.85),
                                        color: Theme.of(context)
                                            .primaryColorLight
                                            .withOpacity(.5)),
                                  ),
                                ],
                              ),
                            ),

                            //second column for stats
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  width: width * .45,
                                  height: height * .25,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        //this should be replaced with the design asset
                                        //was just trying some things
                                        Container(
                                            width: width * .45,
                                            height: height * .18,
                                            child: Row(
                                              children: <Widget>[
                                                SingleChildColumn(text: "M")
                                              ],
                                            )),
                                        Text(
                                          'stats for the week',
                                          style: TextStyle(
                                              fontSize:
                                                  Config.xMargin(context, 3.85),
                                              color: Theme.of(context)
                                                  .primaryColorLight
                                                  .withOpacity(.5)),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                    //logic to populate all reminders from the db with RemindersDescriptionCard widget goes here

                    ...notificationDB.currentNotifications
                        .map((notification) => Container(
                                    child: RemindersDescriptionCard(
                                  height: height,
                                  width: width,
                                  model: notification,
                                ))
                            // ),
                            )
                  ]),
                ),
              ),
            ),
            Badges()
          ])),
    );
  }
}

class SingleChildColumn extends StatelessWidget {
  final String text;

  const SingleChildColumn({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(children: <Widget>[
      divider(height, width, context),
      space(context),
      divider(height, width, context),
      space(context),
      divider(height, width, context),
      space(context),
      divider(height, width, context),
      space(context),
      Text(
        text,
        style: TextStyle(
            fontSize: Config.xMargin(context, 3.85),
            color: Theme.of(context).primaryColorLight.withOpacity(.5)),
      ),
      space(context),
    ]);
  }

  Widget divider(double height, double width, BuildContext context) =>
      Container(
        color: Theme.of(context).buttonColor,
        height: height * 0.03,
        width: width * 0.008,
        child: VerticalDivider(),
      );

  Widget space(BuildContext context) =>
      SizedBox(height: Config.yMargin(context, .5));
}
