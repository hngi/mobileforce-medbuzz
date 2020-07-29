import 'package:MedBuzz/core/database/user_db.dart';
import 'package:MedBuzz/core/models/badge_model.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/reminder_description_card/new_all_reminders_model.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Badges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<NewAllReminderModel>(context);
    var userDb = Provider.of<UserCrud>(context);

    Config config = Config();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColorLight,
            icon: Icon(Icons.fitness_center),
            title: Text('fitness'),
            /* inactiveColor: Theme.of(context).primaryColorDark,
                  activeColor: Theme.of(context).primaryColor, */
          ),
          BottomNavigationBarItem(
            icon: FaIcon(Icons.pin_drop),
            title: Text('Drug'),
            /*  inactiveColor: Theme.of(context).primaryColorDark,
                    activeColor: Theme.of(context).buttonColor*/
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.cloudMeatball),
            title: Text('New Reminders'),
            /*  inactiveColor: Theme.of(context).primaryColorDark,
                    activeColor: Theme.of(context).highlightColor */
          ),
        ]),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SafeArea(
                child: Container(
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        Text(
                          'Badges',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 5.7)),
                        ),
                        SizedBox(
                          height: Config.yMargin(context, 3.7),
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            height: Config.yMargin(context, 19.7),
                            width: Config.xMargin(context, 79),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Theme.of(context).primaryColor),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                          'Good Job ' + "${userDb.user.name} !",
                                          style: TextStyle(
                                              fontSize: Config.textSize(
                                                  context, 5.09),
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryColorLight)),
                                      Text(
                                        'You have logged your \nstats successfully everyday \nin the last 7 days!',
                                        style: TextStyle(
                                            fontSize:
                                                Config.textSize(context, 2.56),
                                            fontWeight: FontWeight.normal,
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 8,
                                        child: Image.asset(
                                          'images/weekdaychart.png',
//                          height: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: Config.yMargin(context, 1.32),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(right: 15),
                                          child: Text(
                                            'stats for the week',
                                            style: TextStyle(
                                                fontSize: Config.textSize(
                                                    context, 2.04),
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          height: Config.yMargin(context, 3.7),
                        ),
                        Container(
                            height: Config.yMargin(context, 68),
                            child: Container(
                              height: Config.yMargin(context, 68),
                              child: GridView(
                                  children: badges
                                      .map(
                                        (badge) =>
                                            // [
                                            Container(
                                          height: Config.yMargin(context, 20),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Image.asset(
                                                  userDb.user.pointsGainedFitness /
                                                              badge.points >=
                                                          1
                                                      ? 'images/fitnessbadge-active.png'
                                                      : 'images/medicationbadge-inactive.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                  height: Config.yMargin(
                                                      context, 0.2),
                                                  width: Config.xMargin(
                                                      context, 25),
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: userDb.user
                                                            .pointsGainedFitness /
                                                        badge.points,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColorLight,
                                                    valueColor:
                                                        new AlwaysStoppedAnimation<
                                                                Color>(
                                                            Theme.of(context)
                                                                .primaryColor),
                                                  )),
                                              Center(
                                                  child: Text(
                                                badge.name,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: Config.textSize(
                                                        context, 3)),
                                              ))
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 20.0,
                                          crossAxisSpacing: 10.0,
                                          childAspectRatio: 0.8,
                                          crossAxisCount: 3)),
                            ))
                      ],
                    )),
              )),
        ));
  }
}
