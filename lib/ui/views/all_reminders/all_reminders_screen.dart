import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/all_reminders/all_reminders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AllRemindersScreen extends StatelessWidget {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemScrollController _monthScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    var allReminders =
        Provider.of<AllRemindersViewModel>(context, listen: true);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).primaryColorDark),
        title: Text(
          'All reminders',
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        elevation: 0.5,
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: Config.yMargin(context, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              //without specifying this height, flutter throws an error because of the grid
              height: height * 0.03,
              child: ScrollablePositionedList.builder(
                //sets default selected day to the index of Date.now() date
                initialScrollIndex: allReminders.selectedDay - 1,
                itemScrollController: _monthScrollController,
                //dynamically sets the itemCount to the number of days in the currently selected month
                itemCount: monthValues.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      allReminders
                          .updateSelectedMonth(monthValues[index].month);
                      _monthScrollController.scrollTo(
                        index: index,
                        duration: Duration(seconds: 1),
                      );
                    },
                    child: Container(
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.008),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: Config.xMargin(context, 2)),
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: Config.xMargin(context, 4.5)),
                      child: Text(
                        monthValues[index].month.toUpperCase(),
                        style:
                            allReminders.calendarMonthTextStyle(context, index),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              //without specifying this height, flutter throws an error because of the grid
              height: height * 0.15,
              child: ScrollablePositionedList.builder(
                //sets default selected day to the index of Date.now() date
                initialScrollIndex: allReminders.selectedDay - 1,
                itemScrollController: _scrollController,
                //dynamically sets the itemCount to the number of days in the currently selected month
                itemCount: allReminders.daysInMonth,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      allReminders.updateSelectedDay(index);
                      _scrollController.scrollTo(
                        index: index,
                        duration: Duration(seconds: 1),
                      );
                    },
                    child: Container(
                      width: width * 0.2,
                      decoration: BoxDecoration(
                        color: allReminders.getButtonColor(context, index),
                        borderRadius: BorderRadius.circular(height * 0.02),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: Config.xMargin(context, 2)),
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: Config.xMargin(context, 4.5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (index + 1).toString(),
                            style:
                                allReminders.calendarTextStyle(context, index),
                          ),
                          SizedBox(height: Config.yMargin(context, 1.5)),
                          Text(
                            allReminders.getWeekDay(index),
                            style: allReminders.calendarSubTextStyle(
                                context, index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.05),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.xMargin(context, 7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Fitness',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text('08:00AM'),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: width,
                    child: InkWell(
                      //Navigate to screen with single reminder i.e the on user clicked on
                      onTap: () {},
                      splashColor: Colors.transparent,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width,
                              height: height * .22,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/sprint.png'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(
                                    Config.xMargin(context, 6)),
                              ),
                            ),
                            SizedBox(height: Config.yMargin(context, 2)),
                            //Type of fitness exercise goes here
                            Text('Running',
                                style: TextStyle(
                                    fontSize: Config.textSize(context, 4),
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor)),
                            SizedBox(height: Config.yMargin(context, 0.6)),
                            Text('30 minutes daily',
                                style: TextStyle(
                                    fontSize: Config.textSize(context, 4.5),
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColorDark)),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.07),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.xMargin(context, 7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Medication',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: double.infinity,
                    child: InkWell(
                      //Navigate to screen with single reminder i.e the on user clicked on
                      onTap: () {},
                      splashColor: Colors.transparent,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "8:00 AM",
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                                width: width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Config.xMargin(context, 3),
                                    vertical: Config.yMargin(context, 1)),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      Config.xMargin(context, 5)),
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
                                        Image.asset(
                                          "images/injection.png",
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          width: width * 0.2,
                                          height: height * 0.1,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Chloroquine Injection',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: height * 0.005),
                                            Text(
                                              '1 shots once daily',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      height: height * 0.02,
//indent: 50.0,
                                      endIndent: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: () {},
                                          child: Text(
                                            'View',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size:
                                                    Config.textSize(context, 3),
                                              ),
                                              SizedBox(
                                                width:
                                                    Config.xMargin(context, 2),
                                              ),
                                              Text(
                                                'Skip',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
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
                                                color: Colors.white,
                                                size:
                                                    Config.textSize(context, 3),
                                              ),
                                              SizedBox(
                                                width:
                                                    Config.xMargin(context, 2),
                                              ),
                                              Text(
                                                'Done',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.07),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.xMargin(context, 7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Water Tracker',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: double.infinity,
                    child: InkWell(
                      //Navigate to screen with single reminder i.e the on user clicked on
                      onTap: () {},
                      splashColor: Colors.transparent,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "10:00 AM",
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                                width: width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Config.xMargin(context, 3),
                                    vertical: Config.yMargin(context, 1)),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(
                                      Config.xMargin(context, 5)),
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
                                        Image.asset(
                                          "images/drops.png",
                                          width: width * 0.2,
                                          height: height * 0.1,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Drink 250ml of water',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: height * 0.005),
                                            Text(
                                              'Upcoming',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorDark),
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
                                      color: Theme.of(context).primaryColorDark,
                                      height: height * 0.02,
                                      endIndent: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: () {},
                                          child: Text(
                                            'View',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.close,
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                size:
                                                    Config.textSize(context, 3),
                                              ),
                                              SizedBox(
                                                width:
                                                    Config.xMargin(context, 2),
                                              ),
                                              Text(
                                                'Skip',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColorDark),
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
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                size:
                                                    Config.textSize(context, 3),
                                              ),
                                              SizedBox(
                                                width:
                                                    Config.xMargin(context, 2),
                                              ),
                                              Text(
                                                'Done',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColorDark),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.07),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.xMargin(context, 7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Appointments',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text('08:00AM'),
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.xMargin(context, 3),
                        vertical: Config.yMargin(context, 1)),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Config.xMargin(context, 6)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.more_vert,
                            size: Config.textSize(context, 5),
                          ),
                          onTap: () {},
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'July',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Config.textSize(context, 3),
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                Text(
                                  '12',
                                  style: TextStyle(
                                    fontSize: Config.textSize(context, 7),
                                    color: Theme.of(context).highlightColor,
                                  ),
                                ),
                                Text(
                                  'Thurs',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Config.textSize(context, 3),
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: Config.xMargin(context, 3),
                            ),
                            Container(
                              color: Theme.of(context).primaryColorDark,
                              height: height * 0.07,
                              width: width * 0.001,
                              child: VerticalDivider(),
                            ),
                            SizedBox(width: Config.xMargin(context, 5)),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Timing',
                                              style: TextStyle(
                                                fontSize: Config.textSize(
                                                    context, 3.4),
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  Config.yMargin(context, 1),
                                            ),
                                            Text(
                                              '6.00 PM',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: Config.textSize(
                                                      context, 3.8)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            width: Config.xMargin(context, 9)),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Appointment for',
                                              style: TextStyle(
                                                fontSize: Config.textSize(
                                                    context, 3.4),
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  Config.yMargin(context, 1),
                                            ),
                                            Text(
                                              'Dance Class',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: Config.textSize(
                                                      context, 3.8)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.03,
                                      width: double.infinity,
                                      child: Divider(
                                        color:
                                            Theme.of(context).primaryColorDark,
//indent: 50.0,
                                        // endIndent: 10.0,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'Make sure to make lots of friends',
                                        style: TextStyle(
                                            fontSize:
                                                Config.textSize(context, 3.8)),
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.07),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.xMargin(context, 7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Diet',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text('10:00AM'),
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.xMargin(context, 3),
                        vertical: Config.yMargin(context, 1)),
//              height: Config.yMargin(context, 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '6:00PM',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Config.textSize(context, 3),
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.more_vert,
                                size: Config.textSize(context, 5),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'July',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Config.textSize(context, 3),
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      fontSize: Config.textSize(context, 7),
                                      color: Theme.of(context).highlightColor,
                                    ),
                                  ),
                                  Text(
                                    'Thurs',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Config.textSize(context, 3),
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Config.xMargin(context, 3),
                            ),
                            Container(
                              color: Theme.of(context).primaryColorDark,
                              height: height * 0.07,
                              width: width * 0.001,
                              child: VerticalDivider(
                                indent: 25.0,
                                endIndent: 25.0,
                              ),
                            ),
                            SizedBox(
                              width: Config.xMargin(context, 5),
                            ),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Carbohydrate, protein and drinks'),
                                    SizedBox(
                                      height: Config.yMargin(context, 1),
                                      width: double.infinity,
                                    ),
                                    Divider(
                                      color: Theme.of(context).primaryColorDark,
                                      height: height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        FlatButton(
                                          child: Text('Skip'),
                                          onPressed: () {},
                                        ),
                                        FlatButton(
                                          onPressed: () {},
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.done),
                                              SizedBox(
                                                width: Config.xMargin(
                                                    context, 0.5),
                                              ),
                                              Text(
                                                'Done',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
