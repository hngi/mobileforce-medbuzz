import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/waterReminderData.dart';
import 'package:MedBuzz/ui/views/add_medication/add_medication_screen.dart';
import 'package:MedBuzz/ui/views/all_reminders/all_reminders_screen.dart';
import 'package:MedBuzz/ui/views/home_screen/home_screen_model.dart';
import 'package:MedBuzz/ui/views/profile_page.dart';
import 'package:MedBuzz/ui/widget/appointment_card.dart';
import 'package:MedBuzz/ui/widget/medication_card.dart';
import 'package:MedBuzz/ui/widget/progress_card.dart';
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

    var waterReminderDB = Provider.of<WaterReminderData>(context);
    waterReminderDB.getWaterReminders();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        Config.xMargin(context, 6),
                        Config.yMargin(context, 2),
                        Config.xMargin(context, 6),
                        Config.yMargin(context, 4),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Good Morning,',
                                    style: TextStyle(
                                      fontSize: Config.xMargin(context, 5),
                                      color: color = Color(0xff333333),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Config.yMargin(context, 2),
                                  ),
                                  Text(
                                    'Juliana',
                                    style: TextStyle(
                                      fontSize: Config.xMargin(context, 6.66),
                                      fontWeight: FontWeight.w600,
                                      color: color = Color(0xff333333),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                padding: EdgeInsets.only(
                                    bottom: Config.xMargin(context, 8.33)),
                                icon: Icon(Icons.notifications_none),
                                iconSize: Config.xMargin(context, 8.33),
                                color: Theme.of(context).primaryColorDark,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.05),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, RouteNames.waterScheduleView),
                            child: ProgressCard(
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
                                          'Water Tracker',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  Config.textSize(context, 3.5),
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.5)),
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
                                                fontSize:
                                                    Config.textSize(context, 4),
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                              ),
                                            ),
                                            Text(
                                              ' of 3500ml',
                                              style: TextStyle(
                                                fontSize: Config.textSize(
                                                    context, 3.7),
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                progressBarColor:
                                    Theme.of(context).primaryColor,
                                title: 'Water Tracker',
                                progress: 250,
                                total: 3500,
                                width: width,
                                height: height * 0.02),
                          ),
                          SizedBox(height: height * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, RouteNames.dietScheduleScreen),
                                child: ProgressCard(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Meal',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                Config.textSize(context, 3.3),
                                            color: Theme.of(context)
                                                .primaryColorDark
                                                .withOpacity(0.5)),
                                      ),
                                      SizedBox(
                                        height: Config.yMargin(context, 1.5),
                                      ),
                                      Text(
                                        '3500',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: Config.xMargin(context, 5),
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      SizedBox(
                                        height: Config.yMargin(context, 1),
                                      ),
                                      Text(
                                        'calories today',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: color = Theme.of(context)
                                                .primaryColorDark
                                                .withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                  progress: 2500,
                                  total: 3500,
                                  width: width * 0.4,
                                  height: height * 0.01,
                                  progressBarColor:
                                      Theme.of(context).buttonColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, RouteNames.fitnessSchedulesScreen),
                                child: ProgressCard(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Steps',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  Config.textSize(context, 3.3),
                                              color: color = Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.5)),
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
                                          ),
                                        ),
                                        SizedBox(
                                          height: Config.yMargin(context, 1),
                                        ),
                                        Text(
                                          'steps today',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: color = Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.5)),
                                        ),
                                      ]),
                                  progress: 1500,
                                  total: 3500,
                                  width: width * 0.4,
                                  height: height * 0.01,
                                  progressBarColor:
                                      Theme.of(context).highlightColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Daily medications',
                                style: TextStyle(
                                  fontSize: Config.textSize(context, 5),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                      context, RouteNames.medicationScreen);
                                },
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                    fontSize: Config.textSize(context, 3.5),
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          MedicationCard(height: height, width: width),
                          SizedBox(height: height * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Upcoming appointments',
                                style: TextStyle(
                                  fontSize: Config.textSize(context, 5),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(context,
                                      RouteNames.scheduledAppointmentsPage);
                                },
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                    fontSize: Config.textSize(context, 3.5),
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AppointmentCard(height: height, width: width),
                        ],
                      ),
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
                    backgroundColor: Theme.of(context).primaryColorLight,
                    labelWidget: Container(
                      margin:
                          EdgeInsets.only(right: Config.xMargin(context, 4)),
                      child: Text(
                        'Appointment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.scheduleAppointmentScreen);
                    },
                  ),
                  SpeedDialChild(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: Image(image: AssetImage('images/drugoutline.png')),
                    labelWidget: Container(
                      margin:
                          EdgeInsets.only(right: Config.xMargin(context, 4)),
                      child: Text(
                        'Medication',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorLight,
                        ),
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
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: Image(image: AssetImage('images/dumbell.png')),
                    labelWidget: Container(
                      margin:
                          EdgeInsets.only(right: Config.xMargin(context, 4)),
                      child: Text(
                        'Fitness',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.fitnessDescriptionScreen);
                    },
                  ),
                  SpeedDialChild(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: Image(image: AssetImage('images/dropoutline.png')),
                    labelWidget: Container(
                      margin:
                          EdgeInsets.only(right: Config.xMargin(context, 4)),
                      child: Text(
                        'Water',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.scheduleWaterReminderScreen);
                    },
                  ),
                  SpeedDialChild(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: Image(image: AssetImage('images/foood.png')),
                    labelWidget: Container(
                      margin:
                          EdgeInsets.only(right: Config.xMargin(context, 4)),
                      child: Text(
                        'Diet',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorLight,
                        ),
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
                defaultBubbleColor:
                    Theme.of(context).primaryColor.withOpacity(.2),
                backgroundColor: Theme.of(context).backgroundColor,
                onTap: (index) {
                  model.updateCurrentIndex(index);
                  _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 150),
                      curve: Curves.easeInOutQuad);
                },
                items: <BubbledNavigationBarItem>[
                  BubbledNavigationBarItem(
                    icon: Icon(CupertinoIcons.home,
                        size: Config.xMargin(context, 8.33),
                        color: Theme.of(context).hintColor),
                    activeIcon: Icon(CupertinoIcons.home,
                        size: Config.xMargin(context, 8.33),
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'Home',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w500,
                          fontSize: Config.textSize(context, 3.5)),
                    ),
                  ),
                  BubbledNavigationBarItem(
                    icon: Icon(CupertinoIcons.bell,
                        size: Config.xMargin(context, 8.33),
                        color: Theme.of(context).hintColor),
                    activeIcon: Icon(CupertinoIcons.bell,
                        size: Config.xMargin(context, 8.33),
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'Reminders',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w500,
                          fontSize: Config.textSize(context, 3.5)),
                    ),
                  ),
                  BubbledNavigationBarItem(
                    icon: Icon(CupertinoIcons.profile_circled,
                        size: Config.xMargin(context, 8.33),
                        color: Theme.of(context).hintColor),
                    activeIcon: Icon(CupertinoIcons.profile_circled,
                        size: Config.xMargin(context, 8.33),
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w500,
                          fontSize: Config.textSize(context, 3.5)),
                    ),
                  ),
                ],
              ));
  }
}
