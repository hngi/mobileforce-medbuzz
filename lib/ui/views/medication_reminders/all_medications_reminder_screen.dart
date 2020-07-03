import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/add_medication/add_medication_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'all_medications_reminder_model.dart';

class MedicationScreen extends StatefulWidget {
  @override
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  @override
  void initState() {
    super.initState();
    //Some sweet magic to animate FAB
    //This makes the FAB disappear as you scroll down
    controller.addListener(() {
      if (controller.offset < 120) {
        Provider.of<MedicationsSchedulesModel>(context).updateVisibility(true);
      } else {
        Provider.of<MedicationsSchedulesModel>(context).updateVisibility(false);
      }
    });
  }

  bool isVisible = true;
  bool isExpanded = false;
  ScrollController controller = ScrollController();
  var _color = Colors.grey;
  var _height = 80;
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MedicationsSchedulesModel>(context);
    //MediaQueries for responsiveness
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                  size: Config.xMargin(context, 10),
                ),
                backgroundColor: Theme.of(context).buttonColor,
                splashColor: Theme.of(context).buttonColor.withOpacity(.9),
                //Navigate to fitness reminder creation screen
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddMedicationScreen()));
                }),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'My Medications',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).primaryColorDark),
        ),
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace,
                color: Theme.of(context).primaryColorDark),

            //Function to navigate to previous screen or home screen (as the case maybe) goes here
            onPressed: () {}),
      ),
      body: SingleChildScrollView(
        controller: controller,
        physics: BouncingScrollPhysics(),
        child: Container(
            margin: EdgeInsets.fromLTRB(Config.xMargin(context, 3),
                Config.yMargin(context, 2), Config.xMargin(context, 3), 0),
            child: Column(
              children: <Widget>[
                Container(
                  height: height * .27,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //ListView to display all dates with entries in the DB
                      Container(
                        height: height * .2,
                        //To be replaced with a ListView.builder for CustomDateButtons with date range from DB
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            //Some example (pronounced igzampl, yunno?)
                            CustomDateButton(
                                date: DateTime.now().add(Duration(days: 1))),
                            CustomDateButton(
                                date: DateTime.now().add(Duration(days: 2))),
                            CustomDateButton(
                                date: DateTime.now().add(Duration(days: 3))),
                            CustomDateButton(
                                date: DateTime.now().add(Duration(days: 4))),
                            CustomDateButton(
                                date: DateTime.now().add(Duration(days: 5))),
                            CustomDateButton(
                                date: DateTime.now().add(Duration(days: 6))),
                            CustomDateButton(date: DateTime.now()),
                            CustomDateButton(
                                date: DateTime.now().add(Duration(days: 10))),
                          ],
                        ),
                      ),
                      //Text widget to display current date in MONTH Year format
                      Text(
                        'JUN 2020',
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: Config.textSize(context, 4)),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Config.yMargin(context, 5)),
                //Here the already saved reminders will be loaded dynamically

                FitnessCard(),
                FitnessCard(),
                FitnessCard(),
                FitnessCard(),
              ],
            )),
      ),
    );
  }
}

class CustomDateButton extends StatelessWidget {
  final DateTime date;

  CustomDateButton({this.date});
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MedicationsSchedulesModel>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(right: Config.xMargin(context, 3)),
      width: Config.xMargin(context, 15.5),
      child: FlatButton(
        onPressed: () => model.changeDay(date),

        //functionality for finding out if today equals the date passed in the constructor
        //I'm using this to determine the color of the container
        color: model.getButtonColor(context, date),
        padding: EdgeInsets.only(right: Config.xMargin(context, 3)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Config.xMargin(context, 10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Day in integer goes here
            Text(
              '${date.day}',
              style: TextStyle(
                  fontSize: Config.textSize(context, 10),
                  fontWeight: FontWeight.bold,
                  color: model.getTextColor(context, date)),
            ),

            SizedBox(
              height: Config.yMargin(context, 4),
            ),

            //Day in shortened words goes here
            //functionality fot this can be extracted and moved to the view model
            Text(
              model.getWeekday(date),
              style: TextStyle(
                  fontSize: Config.textSize(context, 4.8),
                  fontWeight: FontWeight.w600,
                  color: model.getTextColor(context, date)),
            )
          ],
        ),
      ),
    );
  }
}
//class MyExpand extends StatelessWidget {
//  var _color = Colors.grey;
//  var _height = 80.0;
//  @override
//  Widget build(BuildContext context) {
//    var model = Provider.of<MedicationsSchedulesModel>(context);
//    return GestureDetector(
//      onTap: model.animateContainer(),
//      child: Container(
//        padding: EdgeInsets.all(10),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            AnimatedContainer(duration: Duration(seconds: 1),
//            color: _color,
//            height: _height)
//          ],
//        ),
//      ),
//    );
//  }
//}

class FitnessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MedicationsSchedulesModel>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * .35,
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
                style: TextStyle(fontSize: Config.textSize(context, 5)),
              ),
              Divider(
                  thickness: 0.7,
                  color: Theme.of(context).primaryColorDark.withOpacity(.4),
                  indent: Config.xMargin(context, 2.5),
                  endIndent: Config.xMargin(context, 2.5)),
              SizedBox(height: Config.yMargin(context, 2)),
              Container(
                width: width,
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor,
                  borderRadius:
                      BorderRadius.circular(Config.xMargin(context, 8)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ExpansionTile(
                      title: Text(
                        "Chloroquine Injection",
                        style: TextStyle(
                            fontSize: Config.textSize(context, 5),
                            fontWeight: FontWeight.bold,
                            color: model.isExpanded
                                ? Theme.of(context).primaryColorLight
                                : Theme.of(context).primaryColorDark),
                      ),
                      leading: Image.asset(
                        "images/injection.png",
                        color: Theme.of(context).primaryColorLight,
                        width: 50,
                        height: 50,
                      ),
                      subtitle: Text("1 shots once daily",
                          style: TextStyle(
                              fontSize: Config.textSize(context, 5),
                              color: model.isExpanded
                                  ? Theme.of(context).primaryColorLight
                                  : Theme.of(context).primaryColorDark)),
                      backgroundColor: model.isExpanded
                          ? Theme.of(context).hintColor
                          : Theme.of(context).primaryColor,
                      children: <Widget>[
                        Divider(
                            thickness: 1,
                            color: Theme.of(context).primaryColorLight,
                            indent: Config.xMargin(context, 2.0),
                            endIndent: Config.xMargin(context, 2.0)),
                        Padding(
                          padding: EdgeInsets.all(3),
                          child: Row(
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.medicationView);
                                },
                                child: Text(
                                  "View",
                                  style: TextStyle(
                                      fontSize: Config.textSize(context, 5),
                                      color:
                                          Theme.of(context).primaryColorLight),
                                ),
                              ),
                              FlatButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.cancel,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                label: Text(
                                  "Skip",
                                  style: TextStyle(
                                      fontSize: Config.textSize(context, 5),
                                      color:
                                          Theme.of(context).primaryColorLight),
                                ),
                              ),
                              FlatButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.check,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                label: Text(
                                  "Done",
                                  style: TextStyle(
                                      fontSize: Config.textSize(context, 5),
                                      color:
                                          Theme.of(context).primaryColorLight),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onExpansionChanged: (changed) {
                        model.expandTile(changed);
                      }),
                ),
              ),
            ]),
      ),
    );
  }
}
