import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
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
    _tabController = new TabController(vsync: this, length: 2);
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  ScrollController controller = ScrollController();
  List<Widget> _dietReminder = [];
  Widget _buildItem(Widget item, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: SingleChildScrollView(
          controller: controller, child: DietReminderCard()),
    );
  }

  void _insertNewDiet() {
    Widget newDiet = DietReminderCard();
    int insertIndex = 0;
    _dietReminder.insert(insertIndex, newDiet);
    _listKey.currentState.insertItem(insertIndex);
  }

  void removeDiet() {
    // Widget newDiet = DietReminderCard();
    int insertIndex = 0;
    _dietReminder.removeLast();
    _listKey.currentState.insertItem(insertIndex);
  }

  TabController _tabController;

  bool isVisible = true;

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

    var model = Provider.of<DietReminderModel>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: Theme.of(context).primaryColorDark,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: <Tab>[
            Tab(
              text: "Upcoming",
            ),
            Tab(
              text: "Past",
            ),
          ],
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
        ),
        title: Text(
          'My Diet Plan',
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        leading: Icon(
          Icons.keyboard_backspace,
          color: Theme.of(context).primaryColorDark,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              child: Text('Diet tracker'),
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
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 300,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  AnimatedList(
                    key: _listKey,
                    initialItemCount: _dietReminder.length,
                    itemBuilder: (context, index, animation) {
                      return _buildItem(_dietReminder[index], animation);
                    },
                  ),
                  Container(
                    child: Center(
                      child: Text('NO PAST REMINDER'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: model.isVisible ? 1 : 0,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: Visibility(
            visible: model.isVisible,
            child: FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColorLight,
                size: Config.xMargin(context, 7),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              splashColor: Theme.of(context).primaryColor.withOpacity(.9),
              onPressed: () {
                setState(() {
                  _insertNewDiet();
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DietReminderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(8),
              height: 150.0,
              width: 380.0,
              decoration: BoxDecoration(
                  color: appThemeLight.primaryColorLight,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
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
                      Text('6:00PM'),
                      SizedBox(
                        height: Config.yMargin(context, 2),
                      ),
                      Text('July'),
                      Text(
                        '12',
                        style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text('Thurs'),
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
                        'Carbohydrate, Protein and Drinks',
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
