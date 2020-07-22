import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/notifications/fitness_notification_manager.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/add_fitness_screen.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/route_names.dart';
import '../../../core/database/fitness_reminder.dart';
import '../../../core/models/fitness_reminder_model/fitness_reminder.dart';

class SingleFitnessScreen extends StatelessWidget {
  final FitnessReminder rem;

  const SingleFitnessScreen({Key key, this.rem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<FitnessReminderCRUD>(context);
    int noOfDays = rem.endDate.day - rem.startDate.day;
    int currentDay = rem.endDate.day - DateTime.now().day - 1;
    String daysLeft = noOfDays == 0
        ? 'Today is the last day!'
        : '$currentDay day(s) left out of $noOfDays days';
    // FitnessReminder rem = FitnessReminder();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace,
                color: Theme.of(context).primaryColorDark),
//Function to navigate to previous screen
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.fitnessSchedulesScreen);
            }),
      ),
      body: ListView(physics: ScrollPhysics(), children: [
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: Config.yMargin(context, 2.6)),
              child: Align(
                alignment: Alignment.topRight,
                child: FlatButton.icon(
                    onPressed: () {
                      // String time = DateTime.now().toString();
                      // String hour = time.substring(0, 2);
                      // String minutes = time.substring(3, 5);
                      // DateTime now = DateTime.now();
                      // String id =
                      //     '${now.year}${now.month}${now.day}$hour$minutes';
                      // String notifId =
                      //     id.length < 11 ? id : id.substring(0, 10);

                      print(model.id);
                      print(model.selectedIndex);

                      // model.deleteReminder(widget.rem.id.toString());
                      // print("deleting");

                      showDialog(
                          context: context,
                          child: DeleteDialog(
                            id: model.id,
                            index: model.selectedIndex,
                            rem: rem,
                          )
                          //     //show Confirmation dialog
                          );
                      //Do not write any code here
                      // Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    label: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Config.xMargin(context, 5.33)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: Config.xMargin(context, 44),
                    child: Text(
                      '${model.fitnessType[model.selectedIndex]}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: Config.textSize(context, 5.3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: Config.xMargin(context, 5)),
                    child: Image.asset(model.activityType[model.selectedIndex]),
                  ),
                ],
              ),
            ),
            SizedBox(height: Config.yMargin(context, 3)),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                horizontal: Config.xMargin(context, 5.33),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: Config.textSize(context, 4.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: Config.yMargin(context, 1.0)),
                      child: Text(
                        model.description == null || model.description == ""
                            ? 'No Description'
                            : '${model.description}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 4),
                        ),
                        //\n
                      ),
                    ),
                    SizedBox(height: Config.yMargin(context, 10)),
                    Text(
                      'Frequency',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: Config.textSize(context, 4.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
//                          child: ListView.builder(
//                            shrinkWrap: true,
//                            itemCount: medModel.selectedFreq == 'Once'
//                                ? 1
//                                : medModel.selectedFreq == 'Twice' ? 2 : 3,
//                            itemBuilder: (context, index) {
//                              return FrequencyList(
//                                  context: context, index: index);
//                            },
//                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.minDaily.toString() +
                                ' Minutes ' +
                                model.selectedFreq,
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.normal,
                              fontSize: Config.textSize(context, 4),
                            ),
                          ),
                          // Text(
                          //   model.activityTime.toString(),
                          //   style: TextStyle(
                          //     color: Theme.of(context).primaryColor,
                          //     fontWeight: FontWeight.normal,
                          //     fontSize: Config.textSize(context, 3.6),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: Config.yMargin(context, 10)),
                    Text(
                      'Days Left',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: Config.textSize(context, 4.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: Config.yMargin(context, 1.0)),
                      child: Text(
                        daysLeft,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 4),
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: Config.yMargin(context, 10)),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: Config.yMargin(context, 2.0)),
          child: InkWell(
            onTap: () {
              //updates the editing screen with default values
              model.updateSelectedIndex(
                  model.fitnessType.indexOf(rem.fitnesstype));
              model.updateMinDaily(rem.minsperday);
              model.updateFreq(rem.fitnessfreq);
              model.updateActivityTime(TimeOfDay(
                  hour: rem.activityTime[0], minute: rem.activityTime[1]));
              model.updateDescription(rem.description);
              model.updateStartDate(rem.startDate);
              model.updateEndDate(rem.endDate);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FitnessEditScreen(
                            isEdit: true,
                            fitnessModel: rem,
                          )));
            },
            child: Container(
              padding: EdgeInsets.all(Config.xMargin(context, 3.55)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(Config.yMargin(context, 1.28))),
                color: Theme.of(context).primaryColor,
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: Config.xMargin(context, 5.33),
                  right: Config.xMargin(context, 6)), //24,24,27
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.bold,
                  fontSize: Config.textSize(context, 4),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  image(String image) {
    return Image(
      image: AssetImage(image),
      fit: BoxFit.contain,
    );
  }
}

class DeleteDialog extends StatelessWidget {
  final String id;
  final int index;
  final FitnessReminder rem;

  const DeleteDialog({Key key, this.id, this.index, this.rem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final FitnessReminder some = FitnessReminder();
    var model = Provider.of<FitnessReminderCRUD>(context);
    final FitnessNotificationManager fitnessNotificationManager =
        FitnessNotificationManager();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Config.xMargin(context, 4.0)),
      ),
      child: Container(
        height: Config.yMargin(context, 20),
        width: Config.xMargin(context, 150.0),
        //width: Config.xMargin(context, 50),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 23.0, bottom: 20.0),
                child: Text(
                  'Are you sure you want to delete this?',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: Config.yMargin(context, 6.0),
                    width: Config.xMargin(context, 30.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      color: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Config.xMargin(context, 2.0)),
                        side: BorderSide(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.4),
                            width: 1.5),
                      ),
                    ),
                  ),
                  Container(
                    height: Config.yMargin(context, 6.0),
                    width: Config.xMargin(context, 30.0),
                    child: FlatButton(
                      onPressed: () {
                        print("deleted $id $index");
                        model.deleteReminder(rem.id);

                        var diff = rem.endDate.difference(rem.startDate).inDays;
                        var selectedInterval = rem.fitnessfreq == 'Daily'
                            ? 1
                            : rem.fitnessfreq == 'Every 2 days'
                                ? 2
                                : rem.fitnessfreq == 'Every 3 days'
                                    ? 3
                                    : rem.fitnessfreq == 'Every 4 days' ? 4 : 1;

                        int numb = (diff / selectedInterval).ceil();
                        for (var i = 0; i < numb; i++) {
                          var timeValue = rem.startDate.add(
                            Duration(days: selectedInterval * i),
                          );
                          fitnessNotificationManager.removeReminder(
                              rem.startDate.day + timeValue.day + 8000);
                        }
                        // Future.delayed(Duration(seconds: 1), () {
                        Navigator.pushReplacementNamed(
                            context, RouteNames.fitnessSchedulesScreen);
                        // });
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      color: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Config.xMargin(context, 2.0)),
                        side: BorderSide(
                            color: Theme.of(context).hintColor.withOpacity(.4),
                            width: 1.5),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
