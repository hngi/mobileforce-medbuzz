import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/ui/views/add_medication/add_medication_screen.dart';
import 'package:MedBuzz/ui/views/all_reminders/all_reminders_screen.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/add_fitness_screen.dart';
import 'package:MedBuzz/ui/views/home_screen/home_screen_model.dart';
import 'package:MedBuzz/ui/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPressed = false;
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;
  Color color;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);
    _pageController = PageController(
      initialPage: 0,
      keepPage: false,
    );
    _pageController.addListener(handlePageChange);
    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<HomeScreenModel>(context);
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            checkUserDragging(notification);
          },
          child: PageView(
              onPageChanged: (page) => model.updateCurrentIndex(page),
              controller: _pageController,
              children: [
                SafeArea(
                  child: ListView(physics: BouncingScrollPhysics(), children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Good Morning,',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: color = Color(0xff333333),
                                      fontFamily: 'Segoe',
                                    ),
                                  ),
                                  SizedBox(
                                    height: Config.yMargin(context, 2),
                                  ),
                                  Text(
                                    'Juliana',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: color = Color(0xff333333),
                                      fontFamily: 'Segoe',
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                padding: EdgeInsets.only(bottom: 30.0),
                                icon: Icon(Icons.notifications_none),
                                iconSize: 30.0,
                                color: Theme.of(context).primaryColorDark,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 10.0, left: 24.0, right: 24.0),
                          height: Config.yMargin(context, 20),
                          width: Config.xMargin(context, 100),
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
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 10.0,
                                    bottom: 17.0),
                                child: Row(
                                  children: [
                                    Image.asset('images/waterdrop.png'),
                                    SizedBox(
                                      width: Config.xMargin(context, 3),
                                    ),
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Water tracker',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0,
                                            color: color = Color(0xff777777),
                                            fontFamily: 'Segoe',
                                          ),
                                        ),
                                        SizedBox(
                                          height: Config.yMargin(context, 1.5),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '250ml',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.0,
                                                color: color =
                                                    Color(0xff333333),
                                                fontFamily: 'Segoe',
                                              ),
                                            ),
                                            Text(
                                              ' of 3500ml',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: color =
                                                    Color(0xff333333),
                                                fontFamily: 'Segoe',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 3.0,
                                    left: 15.0,
                                    right: 24.0,
                                    bottom: 17.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: Config.yMargin(context, 2),
                                      decoration: BoxDecoration(
                                          color: color = Color(0xffEEEEEE),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                    Container(
                                      height: Config.yMargin(context, 2),
                                      width: Config.xMargin(context, 25),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 24.0,
                                    right: 27.0,
                                    bottom: 24.0,
                                    top: 24.0),
                                height: Config.yMargin(context, 20),
                                width: Config.xMargin(context, 100),
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
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Meal',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0,
                                          color: color = Color(0xff777777),
                                          fontFamily: 'Segoe',
                                        ),
                                      ),
                                      SizedBox(
                                        height: Config.yMargin(context, 1.5),
                                      ),
                                      Text(
                                        '3500',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontFamily: 'Segoe',
                                        ),
                                      ),
                                      SizedBox(
                                        height: Config.yMargin(context, 1),
                                      ),
                                      Text(
                                        'calories today',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: color = Color(0xff777777),
                                          fontFamily: 'Segoe',
                                        ),
                                      ),
                                      SizedBox(
                                        height: Config.yMargin(context, 2),
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 16.0,
                                                right: 16.0,
                                                top: 16.0,
                                                bottom: 16.0),
                                            height: Config.yMargin(context, 1),
                                            decoration: BoxDecoration(
                                                color: color =
                                                    Color(0xffEEEEEE),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 16.0,
                                                top: 16.0,
                                                bottom: 16.0),
                                            height: Config.yMargin(context, 1),
                                            width: Config.xMargin(context, 14),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .buttonColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 20.0,
                                    right: 24.0,
                                    bottom: 24.0,
                                    top: 24.0),
                                height: Config.yMargin(context, 20),
                                width: Config.xMargin(context, 100),
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
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 16.0, right: 15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Steps',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0,
                                          color: color = Color(0xff777777),
                                          fontFamily: 'Segoe',
                                        ),
                                      ),
                                      SizedBox(
                                        height: Config.yMargin(context, 1.5),
                                      ),
                                      Text(
                                        '7500',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontFamily: 'Segoe',
                                        ),
                                      ),
                                      SizedBox(
                                        height: Config.yMargin(context, 1),
                                      ),
                                      Text(
                                        'steps today',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: color = Color(0xff777777),
                                          fontFamily: 'Segoe',
                                        ),
                                      ),
                                      SizedBox(
                                        height: Config.yMargin(context, 2),
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 16.0,
                                                right: 16.0,
                                                top: 16.0,
                                                bottom: 16.0),
                                            height: Config.yMargin(context, 1),
                                            decoration: BoxDecoration(
                                                color: color =
                                                    Color(0xffEEEEEE),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 16.0,
                                                top: 16.0,
                                                bottom: 16.0),
                                            height: Config.yMargin(context, 1),
                                            width: Config.xMargin(context, 14),
                                            decoration: BoxDecoration(
                                                color: color =
                                                    Color(0xff76DBC9),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Daily medications',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Segoe',
                                ),
                              ),
                              FlatButton(
                                onPressed: () {},
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: color = Color(0xff2D7DD2),
                                    fontFamily: 'Segoe',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(24.0),
                          padding: EdgeInsets.only(left: 10.0, right: 24.0),
                          height: Config.yMargin(context, 25),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Image.asset(
                                      'images/injection.png',
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Promethazine',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Segoe',
                                        ),
                                      ),
                                      SizedBox(
                                        height: Config.yMargin(context, 2),
                                      ),
                                      Text(
                                        '1 shots once daily',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Segoe',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 30.0, left: 15.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          '12pm',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Segoe',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Config.yMargin(context, 1),
                                width: Config.xMargin(context, 75),
                                child: Divider(
                                  color: Theme.of(context).primaryColorDark,
                                  indent: 5.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FlatButton(
                                      onPressed: () {},
                                      child: Text(
                                        'View',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Segoe',
                                        ),
                                      )),
                                  FlatButton.icon(
                                      onPressed: () {},
                                      icon: Icon(Icons.close),
                                      label: Text(
                                        'Skip',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Segoe',
                                        ),
                                      )),
                                  FlatButton.icon(
                                      onPressed: () {},
                                      icon: Icon(Icons.check),
                                      label: Text(
                                        'Done',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Segoe',
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Upcoming appointments',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Segoe',
                                ),
                              ),
                              FlatButton(
                                onPressed: () {},
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: color = Color(0xff2D7DD2),
                                    fontFamily: 'Segoe',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(24.0),
                          padding: EdgeInsets.all(8.0),
                          height: Config.yMargin(context, 20),
                          width: Config.xMargin(context, 100),
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
                          child: Row(
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
                                        fontSize: 9.0,
                                        color: color = Color(0xff777777),
                                        fontFamily: 'Segoe',
                                      ),
                                    ),
                                    Text(
                                      '12',
                                      style: TextStyle(
                                        fontSize: 28.0,
                                        color: color = Color(0xff2DBFC3),
                                        fontFamily: 'Segoe',
                                      ),
                                    ),
                                    Text(
                                      'Thurs',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 9.0,
                                        color: color = Color(0xff777777),
                                        fontFamily: 'Segoe',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Config.xMargin(context, 3),
                              ),
                              Container(
                                color: Colors.black45,
                                height: Config.yMargin(context, 8),
                                width: Config.xMargin(context, 0.1),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  fontSize: 12.0,
                                                  color: color =
                                                      Color(0xff777777),
                                                  fontFamily: 'Segoe',
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
                                                  fontSize: 14.0,
                                                  fontFamily: 'Segoe',
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: Config.xMargin(context, 9),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Appointment for',
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: color =
                                                      Color(0xff777777),
                                                  fontFamily: 'Segoe',
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
                                                  fontSize: 14.0,
                                                  fontFamily: 'Segoe',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Config.yMargin(context, 3),
                                        width: Config.xMargin(context, 63),
                                        child: Divider(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          //indent: 50.0,
                                          endIndent: 10.0,
                                        ),
                                      ),
                                      Container(
                                        width: Config.xMargin(context, 50),
                                        height: Config.yMargin(context, 6),
                                        child: Text(
                                          'Make sure to make lots of friends',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: 'Segoe',
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {},
                                  padding: EdgeInsets.only(
                                      bottom: 100.0, left: 28.0),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                AllRemindersScreen(),
                ProfilePage(),
              ]),
        ),
        floatingActionButton: model.currentIndex != 0
            ? Container()
            : SpeedDial(
                backgroundColor: Theme.of(context).primaryColor,
                onOpen: () {
                  setState(() {
                    isPressed = true;
                  });
                },
                onClose: () {
                  setState(() {
                    isPressed = false;
                  });
                },
                child: Icon(isPressed == true ? Icons.close : Icons.add),
                overlayColor: Colors.black,
                overlayOpacity: 0.7,
                children: [
                  SpeedDialChild(
                    child: Image(image: AssetImage('images/calender.png')),
                    backgroundColor: Colors.white,
                    labelWidget: Container(
                      margin:
                          EdgeInsets.only(right: Config.xMargin(context, 4)),
                      child: Text(
                        'Appointment',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.scheduleAppointmentScreen);
                    },
                  ),
                  SpeedDialChild(
                    backgroundColor: Colors.white,
                    child: Image(image: AssetImage('images/drugoutline.png')),
                    labelWidget: Container(
                      margin:
                          EdgeInsets.only(right: Config.xMargin(context, 4)),
                      child: Text(
                        'Medication',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddMedicationScreen()));
                    },
                  ),
                  SpeedDialChild(
                    backgroundColor: Colors.white,
                    child: Image(image: AssetImage('images/dumbell.png')),
                    labelWidget: Container(
                      margin:
                          EdgeInsets.only(right: Config.xMargin(context, 4)),
                      child: Text(
                        'Fitness',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.fitnessSchedulesScreen);
                    },
                  ),
                  SpeedDialChild(
                    backgroundColor: Colors.white,
                    child: Image(image: AssetImage('images/dropoutline.png')),
                    labelWidget: Container(
                      margin:
                          EdgeInsets.only(right: Config.xMargin(context, 4)),
                      child: Text(
                        'Water',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.scheduleWaterReminderScreen);
                    },
                  ),
                  SpeedDialChild(
                    backgroundColor: Colors.white,
                    child: Image(image: AssetImage('images/foood.png')),
                    labelWidget: Container(
                      margin:
                          EdgeInsets.only(right: Config.xMargin(context, 4)),
                      child: Text(
                        'Diet',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.scheduleDietReminderScreen);
                    },
                  ),
                ],
              ),
        //Crazelu extracted BottomNavigationBar widget to Widgets folder
        bottomNavigationBar: isPressed == true
            ? null
            : BubbledNavigationBar(
                controller: _menuPositionController,
                initialIndex: 0,
                defaultBubbleColor: Theme.of(context).primaryColorLight,
                backgroundColor: Theme.of(context).backgroundColor,
                onTap: (index) {
                  model.updateCurrentIndex(index);
                  _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOutQuad);
                },
                items: <BubbledNavigationBarItem>[
                  BubbledNavigationBarItem(
                    icon: Icon(CupertinoIcons.home,
                        size: 30, color: Theme.of(context).primaryColorDark),
                    activeIcon: Icon(CupertinoIcons.home,
                        size: 30, color: Colors.blueAccent),
                    title: Text(
                      'Home',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 12),
                    ),
                  ),
                  BubbledNavigationBarItem(
                    icon: Icon(CupertinoIcons.bell,
                        size: 30, color: Theme.of(context).primaryColorDark),
                    activeIcon: Icon(CupertinoIcons.bell,
                        size: 30, color: Colors.blueAccent),
                    title: Text(
                      'Reminders',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 12),
                    ),
                  ),
                  BubbledNavigationBarItem(
                    icon: Icon(CupertinoIcons.profile_circled,
                        size: 30, color: Theme.of(context).primaryColorDark),
                    activeIcon: Icon(CupertinoIcons.profile_circled,
                        size: 30, color: Colors.blueAccent),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 12),
                    ),
                  ),
                ],
              ));
  }
}
