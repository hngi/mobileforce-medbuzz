import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/reminder_description_card/new_all_reminders_model.dart';
import 'package:MedBuzz/ui/views/reminder_description_card/new_all_reminders_screen.dart';
import 'package:MedBuzz/ui/widget/progress_card.dart';
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
                      style: TextStyle(fontSize: Config.textSize(context, 5.7)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Good Job Julia!',
                                      style: TextStyle(
                                          fontSize:
                                              Config.textSize(context, 5.09),
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
                                            fontSize:
                                                Config.textSize(context, 2.04),
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
                      child: GridView(
                          children: [
                            Container(
                              height: Config.yMargin(context, 20),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                    'images/fitnessbadge-active.png',
                                    fit: BoxFit.cover,
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: Config.yMargin(context, 0.2),
                                      width: Config.xMargin(context, 25),
                                      child: LinearProgressIndicator(
                                        value: 1,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      )),
                                  Center(
                                      child: Text(
                                    'Rookie \n Badge ',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            Config.textSize(context, 4.2)),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              height: Config.yMargin(context, 20),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                    'images/dietbadge-active.png',
                                    fit: BoxFit.cover,
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: Config.yMargin(context, 0.2),
                                      width: Config.xMargin(context, 25),
                                      child: LinearProgressIndicator(
                                        value: 1,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      )),
                                  Center(
                                      child: Text(
                                    'Demi\nBadge ',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            Config.textSize(context, 4.2)),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              height: Config.yMargin(context, 20),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                    'images/dietbadge-active.png',
                                    fit: BoxFit.cover,
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: Config.yMargin(context, 0.2),
                                      width: Config.xMargin(context, 25),
                                      child: LinearProgressIndicator(
                                        value: 1,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      )),
                                  Center(
                                      child: Text(
                                    'Go-Getter\n    Badge ',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            Config.textSize(context, 4.2)),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              height: Config.yMargin(context, 20),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                    'images/dietbadge-active.png',
                                    fit: BoxFit.cover,
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: Config.yMargin(context, 0.2),
                                      width: Config.xMargin(context, 25),
                                      child: LinearProgressIndicator(
                                        value: 1,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      )),
                                  Center(
                                      child: Text(
                                    'Interminnet\n    Badge ',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            Config.textSize(context, 4.2)),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              height: Config.yMargin(context, 20),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                    'images/dietbadge-active.png',
                                    fit: BoxFit.cover,
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: Config.yMargin(context, 0.2),
                                      width: Config.xMargin(context, 25),
                                      child: LinearProgressIndicator(
                                        value: 1,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      )),
                                  Center(
                                      child: Text(
                                    'Oracle\nBadge ',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            Config.textSize(context, 4.2)),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              height: Config.yMargin(context, 20),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                    'images/medicationbadge-inactive.png',
                                    fit: BoxFit.cover,
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: Config.yMargin(context, 0.2),
                                      width: Config.xMargin(context, 25),
                                      child: LinearProgressIndicator(
                                        value: .6,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      )),
                                  Center(
                                      child: Text(
                                    'Neon\nBadge ',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            Config.textSize(context, 4.2)),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              height: Config.yMargin(context, 20),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                    'images/medicationbadge-inactive.png',
                                    fit: BoxFit.cover,
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: Config.yMargin(context, 0.2),
                                      width: Config.xMargin(context, 25),
                                      child: LinearProgressIndicator(
                                        value: .3,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      )),
                                  Center(
                                      child: Text(
                                    'Warrior\n  Badge ',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            Config.textSize(context, 4.2)),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              height: Config.yMargin(context, 20),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                    'images/dietbadge-active.png',
                                    fit: BoxFit.cover,
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: Config.yMargin(context, 0.2),
                                      width: Config.xMargin(context, 25),
                                      child: LinearProgressIndicator(
                                        value: 1,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      )),
                                  Center(
                                      child: Text(
                                    'king\nBadge ',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            Config.textSize(context, 4.2)),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              height: Config.yMargin(context, 20),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                    'images/waterbadge-inactive.png',
                                    fit: BoxFit.cover,
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: Config.yMargin(context, 0.2),
                                      width: Config.xMargin(context, 25),
                                      child: LinearProgressIndicator(
                                        value: .6,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      )),
                                  Center(
                                      child: Text(
                                    'Sahara\nBadge ',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            Config.textSize(context, 4.2)),
                                  ))
                                ],
                              ),
                            ),
                          ],
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 20.0,
                                  crossAxisSpacing: 10.0,
                                  childAspectRatio: 0.8,
                                  crossAxisCount: 3)),
                    )
                  ],
                )),
          )),
    ));
  }
}
