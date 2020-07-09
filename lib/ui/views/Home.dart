import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Initialization of the ratemyapp package
  // Read the docs for the meaning of those numbers it is quite easy
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'launch_',
    minDays: 7,
    minLaunches: 7,
    remindDays: 7,
    remindLaunches: 7,
  );

  // Placed in the initstate so that it is triggered at the beginning of the app could be made more dynamic too
  // The rest of the code here is straight forward so do well to take your time to check the docs so you'd get the full gist
  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then(
      (_) {
        if (_rateMyApp.shouldOpenDialog) {
          _rateMyApp.showStarRateDialog(
            context,
            title: 'Please Rate Us!',
            message: 'Please rate your experience with our app',
            ignoreIOS: false,
            actionsBuilder: (context, stars) {
              return [
                Container(
                  height: 90,
                  width: 300,
                  child: Column(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            await _rateMyApp.callEvent(
                                RateMyAppEventType.rateButtonPressed);
                            Navigator.pop<RateMyAppDialogButton>(
                                context, RateMyAppDialogButton.rate);
                          },
                          child: Container(
                            child: Center(
                                child: Text(
                              'Rate Now',
                              style: TextStyle(
                                  color: ThemeData().primaryColorLight),
                            )),
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: ThemeData().primaryColor,
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          await _rateMyApp
                              .callEvent(RateMyAppEventType.laterButtonPressed);
                          Navigator.pop<RateMyAppDialogButton>(
                              context, RateMyAppDialogButton.later);
                        },
                        child: Text(
                          'Maybe Later',
                          style: TextStyle(color: ThemeData().hintColor),
                        ),
                      )
                    ],
                  ),
                )
              ];
            },
            onDismissed: () =>
                _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
            dialogStyle: DialogStyle(
              titleStyle: ThemeData().textTheme.headline5,
              messageStyle: ThemeData().textTheme.caption,
              messageAlign: TextAlign.center,
              titleAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 20),
            ),
            starRatingOptions: StarRatingOptions(
                starsSize: 30,
                starsSpacing: 5,
                allowHalfRating: true,
                starsFillColor: ThemeData().primaryColor,
                starsBorderColor: ThemeData().hintColor),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Theme.of(context).backgroundColor);
  }
}
