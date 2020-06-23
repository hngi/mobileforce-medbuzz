import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../size_config/config.dart';
import 'schedule_water_reminder_screen.dart';

class WaterScheduleViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: Container(
        margin: EdgeInsets.only(
            bottom: Config.yMargin(context, 2),
            right: Config.xMargin(context, 4)),
        child: SizedBox(
          height: 90,
          width: 90,
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WaterScheduleScreen()));
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.add,
              size: 47,
            ),
          ),
        ),
      ),
      body: WaterScheduleView(),
    );
  }
}

class WaterScheduleView extends StatefulWidget {
  @override
  _WaterScheduleViewState createState() => _WaterScheduleViewState();
}

class _WaterScheduleViewState extends State<WaterScheduleView> {
  int currentLevel = 1500;
  int averageLevel = 3000;
  double progress = 0;
  bool _skip = false;
  bool _done = false;
  DateTime time = DateTime.now();
  String formattedTime;
  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
    progressBar();
  }

  //Function to change the value of the CircularProgressIndicator
  void progressBar() {
    if (currentLevel <= 100) {
      setState(() {
        progress = 0;
      });
    } else if (currentLevel <= 500) {
      setState(() {
        progress = 0.2;
      });
    } else if (currentLevel < 1500) {
      setState(() {
        progress = 0.3;
      });
    } else if (currentLevel == 1500) {
      setState(() {
        progress = 0.5;
      });
    } else if (currentLevel <= 2000) {
      setState(() {
        progress = 0.6;
      });
    } else if (currentLevel < 3000) {
      setState(() {
        progress = 0.8;
      });
    } else if (currentLevel == 3000) {
      setState(() {
        progress = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    formattedTime = DateFormat.jm().format(time);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 60),
      child: SingleChildScrollView(
        //container wrapping all the widgets
        child: Container(
          margin: EdgeInsets.only(
              right: Config.xMargin(context, 7),
              left: Config.xMargin(context, 7),
              top: Config.yMargin(context, 5),
              bottom: Config.yMargin(context, 10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.37,
                      width: width * 0.7,
                      child: CircularProgressIndicator(
                          backgroundColor: Color(0xffE5E5E5),
                          valueColor: currentLevel < 1500
                              ? AlwaysStoppedAnimation(Colors.red)
                              : AlwaysStoppedAnimation(
                                  Theme.of(context).primaryColor),
                          value: progress,
                          strokeWidth: 15),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: Config.xMargin(context, 30),
                          top: Config.yMargin(context, 9)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Image(
                                image: AssetImage('images/bigdrop.png'),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: Config.xMargin(context, 6),
                                    top: Config.yMargin(context, 1)),
                                child: Image(
                                  image: AssetImage('images/smalldrop.png'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: Config.yMargin(context, 19.8),
                          left: Config.xMargin(context, 24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Proper data will be fetched from DB
                          Text(
                            '$currentLevel' + 'ml',
                            style: TextStyle(
                                fontSize: Config.textSize(context, 7),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: Config.yMargin(context, 0.7),
                          ),
                          Text('of $averageLevel' + 'ml',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 4.5),
                                  color: Color(0xff4F4F4F)))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Config.yMargin(context, 5),
              ),
              //Tap cards at your own risk :). Proper card display will be done when fetching data from DB
              card('Drink 1000ml of water'),
              card('Drink 1000ml of water'),
              card('Drink 1000ml of water'),
              card('Drink 1000ml of water')
            ],
          ),
        ),
      ),
    );
  }

  Widget card(String text) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: Config.yMargin(context, 2)),
      height: _isHidden ? height * 0.15 : height * 0.25,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isHidden = false;
          });
        },
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height * 0.03)),
          child: Container(
            margin: EdgeInsets.only(
                left: Config.xMargin(context, 5),
                right: Config.xMargin(context, 5),
                top: Config.yMargin(context, 3)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Config.textSize(context, 4.2),
                          ),
                        ),
                        SizedBox(
                          height: Config.yMargin(context, 0.7),
                        ),

                        // To display status of reminder
                        Text(
                          _skip == true
                              ? 'Skipped'
                              : _done == true ? 'Completed' : 'Upcoming',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 3.7)),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(
                              left: Config.xMargin(context, 3.5),
                              bottom: Config.yMargin(context, 2.5)),
                          child: Text(formattedTime)),
                    )
                  ],
                ),
                SizedBox(
                  height: Config.yMargin(context, 2.5),
                ),
                !_isHidden
                    ? Divider(
                        thickness: 2,
                      )
                    : Container(),
                !_isHidden
                    ? Row(
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
                      )
                    : Container()
              ],
            ),
          ),
        ),
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
          ),
          SizedBox(
            width: Config.xMargin(context, 2),
          ),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Config.textSize(context, 3.7)),
          ),
        ],
      ),
    );
  }
}
