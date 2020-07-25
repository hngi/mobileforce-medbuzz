import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/reminder_description_card/new_all_reminders_model.dart';
import 'package:MedBuzz/ui/views/reminder_description_card/new_all_reminders_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Badges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<NewAllReminderModel>(context);

    Config config = Config();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SafeArea(
              child: Container(
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                      Text(
                        'Badges',
                        style:
                            TextStyle(fontSize: Config.textSize(context, 5.7)),
                      ),
                      SizedBox(
                        height: Config.yMargin(context, 3.7),
                      ),
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
                                  color: Theme.of(context).primaryColorLight),
                            ),
                            SizedBox(height: Config.yMargin(context, 1)),
                            Text(
                              model.getUserProgress(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: Config.xMargin(context, 3.85),
                                  color: Theme.of(context).primaryColorLight
                                  //  .withOpacity(.5)
                                  ),
                            ),
                          ],
                        ),
                      ),

                      //second column for stats
                      Column(
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

                                  Text(
                                    'stats for the week',
                                    style: TextStyle(
                                        fontSize: Config.xMargin(context, 3.85),
                                        color:
                                            Theme.of(context).primaryColorLight
                                        //.withOpacity(.5)
                                        ),
                                  )
                                ]),
                          )
                        ],
                      )
                    ],
                  )),
            )));
  }
}
