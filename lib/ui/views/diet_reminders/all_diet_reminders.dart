import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/diet_reminderDB.dart';
import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:MedBuzz/ui/widget/diet_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:MedBuzz/ui/views/diet_reminders/diet_reminders_model.dart';

class DietScheduleScreen extends StatefulWidget {
  DietScheduleScreen({this.payload});

  final String payload;
  @override
  _DietScheduleScreenState createState() => _DietScheduleScreenState();
}

class _DietScheduleScreenState extends State<DietScheduleScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
  }

  // final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  ScrollController controller = ScrollController();
  // List<Widget> _dietReminder = [];
  // Widget _buildItem(DietModel diet, Animation animation) {
  //   return SizeTransition(
  //     sizeFactor: animation,
  //     child: SingleChildScrollView(
  //         controller: controller, child: DietReminderCard(diet: diet)),
  //   );
  // }

  // void _insertNewDiet() {
  //   Widget newDiet = DietReminderCard();
  //   int insertIndex = 0;
  //   _dietReminder.insert(insertIndex, newDiet);
  //   _listKey.currentState.insertItem(insertIndex);
  // }

  // void removeDiet() {
  //   // Widget newDiet = DietReminderCard();
  //   int insertIndex = 0;
  //   _dietReminder.removeLast();
  //   _listKey.currentState.insertItem(insertIndex);
  // }

  TabController _tabController;

  bool isVisible = true;
  PieChartData _chartData = PieChartData(
    sections: [PieChartSectionData(value: 76)],
  );

  @override
  Widget build(BuildContext context) {
    //This makes the FAB disappear as you scroll down
    controller.addListener(() {
      if (controller.offset < 120) {
        Provider.of<DietReminderModel>(context).updateVisibility(true);
      } else {
        Provider.of<DietReminderModel>(context).updateVisibility(false);
      }
    });
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var db = Provider.of<DietReminderDB>(context, listen: true);
    db.getAlldiets();
    var model = Provider.of<DietReminderModel>(context, listen: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model.updateAllDietsBasedOnToday(db.allDiets);
    });

    // print(model.upcomingDiets);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Theme.of(context).backgroundColor,
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Theme.of(context).primaryColorDark,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: <Tab>[
              Tab(
                text: "Ongoing",
              ),
              Tab(
                text: "Upcoming",
              ),
              Tab(
                text: "Past",
              ),
              Tab(
                text: "Report",
              ),
            ],
            controller: _tabController,
            labelColor: Theme.of(context).primaryColor,
          ),
          title: Text(
            'My Diet Plan',
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.homePage);
              }),
          /*   actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              child: Text(
                'Diet tracker',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius:
                    BorderRadius.circular(Config.xMargin(context, 10)),
              ),
            ),
          )
        ], */
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushReplacementNamed(context, RouteNames.homePage);
            return Future.value(false);
          },
          child: Container(
            margin: EdgeInsets.only(top: Config.yMargin(context, 4)),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                model.ongoingDiets.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: Config.xMargin(context, 7)),
                        itemCount: model.ongoingDiets.length,
                        itemBuilder: (context, index) =>
                            // var diets = db.upcomingDiets;
                            // var item = diets[index];

                            DietCard(
                                height: height,
                                width: width,
                                diet: model.ongoingDiets[index]))
                    : Container(
                        color: Theme.of(context).backgroundColor,
                        height: height,
                        width: width,
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                              'No ongoing diet reminder.\nClick the button to add one',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.xMargin(context, 5.55))),
                        ),
                      ),
                model.upcomingDiets.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: Config.xMargin(context, 7)),
                        itemCount: model.upcomingDiets.length,
                        itemBuilder: (context, index) =>
                            // var diets = db.upcomingDiets;
                            // var item = diets[index];

                            DietCard(
                                height: height,
                                width: width,
                                diet: model.upcomingDiets[index]))
                    : Container(
                        color: Theme.of(context).backgroundColor,
                        height: height,
                        width: width,
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                              'No upcoming diet reminder.\nClick the button to add one',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.xMargin(context, 5.55))),
                        ),
                      ),
                model.pastDiets.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: Config.xMargin(context, 7)),
                        itemCount: model.pastDiets.length,
                        itemBuilder: (context, index) =>
                            model.pastDiets.length == 0
                                ? Text('')
                                : DietCard(
                                    height: height,
                                    width: width,
                                    diet: model.pastDiets[index]),
                      )
                    : Container(
                        color: Theme.of(context).backgroundColor,
                        height: height,
                        width: width,
                        alignment: Alignment.center,
                        child: Center(
                            child: Text('No past reminder',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Config.xMargin(context, 5.55)))),
                      ),
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.xMargin(context, 5)),
                    child: PageView(
                      children: <Widget>[
                        PieChart(
                          PieChartData(
                            centerSpaceRadius: width * 0.3,
                            sections: [
                              PieChartSectionData(
                                value: db.getNumberOfDietsWithFoodClass(
                                            'Vegetables') ==
                                        0
                                    ? 10
                                    : db.getNumberOfDietsWithFoodClass(
                                        'Vegetables'),
                                title:
                                    'Veg (${db.getNumberOfDietsWithFoodClass('Vegetables')})',
                                color: Theme.of(context).accentColor,
                              ),
                              PieChartSectionData(
                                title:
                                    'Fruits (${db.getNumberOfDietsWithFoodClass('Fruit')})',
                                value: db.getNumberOfDietsWithFoodClass(
                                            'Fruit') ==
                                        0
                                    ? 10
                                    : db.getNumberOfDietsWithFoodClass('Fruit'),
                                color: Theme.of(context).highlightColor,
                              ),
                              PieChartSectionData(
                                title:
                                    'Drinks (${db.getNumberOfDietsWithFoodClass('Drink')})',
                                value: db.getNumberOfDietsWithFoodClass(
                                            'Drink') ==
                                        0
                                    ? 10
                                    : db.getNumberOfDietsWithFoodClass('Drink'),
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
        floatingActionButton: AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: model.isVisible ? 1 : 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            child: Visibility(
              visible: model.isVisible,
              child: Container(
                margin: EdgeInsets.only(
                    bottom: Config.yMargin(context, 2),
                    right: Config.xMargin(context, 4)),
                child: SizedBox(
                  height: height * 0.08,
                  width: height * 0.08,
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColorLight,
                      size: Config.xMargin(context, 5),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    splashColor: Theme.of(context).primaryColor.withOpacity(.9),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteNames.scheduleDietReminderScreen);
                      // setState(() {
                      //   _insertNewDiet();
                      // });
                    },
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class DietReminderCard extends StatelessWidget {
  final DietModel diet;

  const DietReminderCard({Key key, this.diet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(diet.foodClasses);
    var model = Provider.of<DietReminderModel>(context);
    return Padding(
      padding: EdgeInsets.only(
          left: Config.xMargin(context, 2.22),
          right: Config.xMargin(context, 2.22),
          top: Config.xMargin(context, 5.55)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(Config.xMargin(context, 2.22)),
              // height: Config.yMargin(context, 24.3),
              // width: Config.xMargin(context, 105.55),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  shape: BoxShape.rectangle,
                  borderRadius:
                      BorderRadius.circular(Config.xMargin(context, 4.17)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFEDEFF2),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                  ]),
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        DateFormat.jm().format(diet.startDate).toString(),
                        style:
                            TextStyle(fontSize: Config.textSize(context, 3.5)),
                      ),
                      SizedBox(
                        height: Config.yMargin(context, 2),
                      ),
                      Text(model.monthFromInt(diet.startDate.month)),
                      Text(
                        '${diet.startDate.day}',
                        style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(model.weekayFromInt(diet.startDate.weekday)),
                    ],
                  ),
                  SizedBox(
                    width: Config.xMargin(context, 4),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Config.yMargin(context, 5),
                        bottom: Config.yMargin(context, 5)),
                    child: VerticalDivider(
                      width: Config.xMargin(context, 0.1),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: Config.xMargin(context, 5),
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: Config.xMargin(context, 7),
                      ),
                      Text(
                        diet.dietName,
                        // model.foodClassesFromDietModel(diet.foodClasses ?? []),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Config.xMargin(context, 1),
                      ),
                      Divider(
                        thickness: Config.xMargin(context, 10),
                        height: Config.xMargin(context, 3.1),
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: Config.xMargin(context, 5),
                      ),
                      Row(
                        children: <Widget>[
                          FlatButton(
                            child: Text('Skip'),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: Config.xMargin(context, 10),
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.done),
                                SizedBox(
                                  width: Config.xMargin(context, 0.5),
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
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
