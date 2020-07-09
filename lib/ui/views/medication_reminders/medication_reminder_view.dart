import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:MedBuzz/core/notifications/drug_notification_manager.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/water_reminders/single_water_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var medModel = Provider.of<MedicationData>(context);
    int no_of_days = medModel.endDate.day - medModel.startDate.day;
    int current_day = medModel.endDate.day - DateTime.now().day - 1;
    String days_left = no_of_days == 0
        ? 'Today is the last day!'
        : '$current_day day(s) left out of $no_of_days days';

    //Set Widget to use Provider
    return Consumer<MedicationData>(
      builder: (context, medModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: Theme.of(context).backgroundColor,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: Navigator.of(context).pop),
          ),
          body: ListView(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(right: Config.yMargin(context, 2.6)),
                    child: FlatButton.icon(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              child: DeleteBox(
                                  deletion_key: medModel.id,
                                  newReminder: medModel
                                      .getSchedule()) //show Confirmation dialog
                              );
                          showSnackBar(context);
                          Future.delayed(Duration(seconds: 1)).then((value) {
                            medModel.deleteSchedule(key);
                            Navigator.of(context).pop(true);
                          });
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
                  //SizedBox(height: Config.yMargin(context, 3)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.xMargin(context, 5.33)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: Config.xMargin(context, 44),
                          child: Text(
                            '${medModel.drugName}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: Config.textSize(context, 5.3),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              right: Config.xMargin(context, 5)),
                          child: Image.asset(
                              medModel.images[medModel.selectedIndex]),
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
                            padding: EdgeInsets.only(
                                top: Config.yMargin(context, 1.0)),
                            child: Text(
                              medModel.description == null ||
                                      medModel.description == ""
                                  ? 'No Description'
                                  : '${medModel.description}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: Config.textSize(context, 4),
                              ),
                              //\n
                            ),
                          ),
                          SizedBox(height: Config.yMargin(context, 10)),
                          Text(
                            'Dosage',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: Config.textSize(context, 4.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: medModel.selectedFreq == 'Once'
                                  ? 1
                                  : medModel.selectedFreq == 'Twice' ? 2 : 3,
                              itemBuilder: (context, index) {
                                return FrequencyList(
                                    context: context, index: index);
                              },
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
                            padding: EdgeInsets.only(
                                top: Config.yMargin(context, 1.0)),
                            child: Text(
                              days_left,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: Config.textSize(context, 4),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: Config.yMargin(context, 10)),

                  Padding(
                    padding:
                        EdgeInsets.only(bottom: Config.yMargin(context, 2.0)),
                    child: InkWell(
                      onTap: () {
                        medModel.isEditing = true;
                        Navigator.pushNamed(
                            context, RouteNames.addMedicationScreen);
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
                ],
              ),
            ),
          ]),
        );
      },
    );
  }

  DrugNotificationManager() {}
}

class FrequencyList extends StatelessWidget {
  final int index;
  final BuildContext context;

  FrequencyList({this.context, this.index});

  @override
  Widget build(BuildContext context) {
    var medModel = Provider.of<MedicationData>(context);
    return Container(
      // margin: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${medModel.dosage} Once Daily',
            style: TextStyle(
              fontSize: Config.textSize(context, 4),
            ),
          ),
          Text(
            index == 0
                ? medModel.firstTime.format(context)
                : index == 1
                    ? medModel.secondTime.format(context)
                    : medModel.thirdTime.format(context),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: Config.textSize(context, 3.6),
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteBox extends StatelessWidget {
  String deletion_key;
  MedicationReminder newReminder;

  DeleteBox({this.deletion_key, this.newReminder});

  @override
  Widget build(BuildContext context) {
    final medModel = Provider.of<MedicationData>(context);

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
                        //Code to delete using key
                        medModel.deleteSchedule(deletion_key);

                        //Code to delete notification
                        switch (newReminder.frequency) {
                          case 'Once':
                            deleteNotification(
                                newReminder, newReminder.firstTime);
                            break;
                          case 'Twice':
                            deleteNotification(
                                newReminder, newReminder.firstTime);
                            deleteNotification(
                                newReminder, newReminder.secondTime);
                            break;
                          case 'Thrice':
                            deleteNotification(
                                newReminder, newReminder.firstTime);
                            deleteNotification(
                                newReminder, newReminder.secondTime);
                            deleteNotification(
                                newReminder, newReminder.thirdTime);
                            break;
                        }
                        Navigator.of(context)
                            .popAndPushNamed(RouteNames.medicationScreen);
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

void deleteNotification(MedicationReminder med, List<int> time) {
  DateTime date = DateTime.parse(med.id);
  int id =
      num.parse('${date.year}${date.month}${date.day}${time[0]}${time[1]}');

  DrugNotificationManager notificationManager = DrugNotificationManager();
  notificationManager.removeReminder(id);
  print("Deleted Notification of id $id");
}
