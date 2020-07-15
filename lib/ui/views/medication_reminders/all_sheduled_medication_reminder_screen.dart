import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/medication_reminders/all_medications_reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'all_medications_reminder_screen.dart';

class SchedulledMedicationScreen extends StatefulWidget {
  @override
  _SchedulledMedicationScreenState createState() =>
      _SchedulledMedicationScreenState();
}

class _SchedulledMedicationScreenState
    extends State<SchedulledMedicationScreen> {
  @override
  Widget build(BuildContext context) {
    //Fetch data from DB to List in model
    Provider.of<MedicationData>(context).getMedicationReminder();

    //set model
    var model = Provider.of<MedicationData>(context);
//    var medicationReminders =
//        Provider.of<MedicationsSchedulesModel>(context, listen: true);
//    var medicationReminderDB =
//        Provider.of<MedicationData>(context, listen: true);

    model.getMedicationReminder();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model.updateAvailableMedicationReminder(
          model.medicationReminder);
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: appThemeLight.backgroundColor,
        appBar: AppBar(
          backgroundColor: appThemeLight.appBarTheme.color,
          title: Text(
            "My Medication",
            style: appThemeLight.textTheme.headline6,
            textScaleFactor: 1.2,
          ),
          leading: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: appThemeLight.appBarTheme.iconTheme.color,),
              onPressed: () => {
                Navigator.pushReplacementNamed(context, RouteNames.homePage)
              },
            ),
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: appThemeLight.primaryColor,
            labelColor: appThemeLight.primaryColorDark.withOpacity(0.9),
            unselectedLabelColor:
            appThemeLight.primaryColorDark.withOpacity(0.9),
            indicatorWeight: 2.0,
            tabs: [
              Tab(
                child: Text(
                  'Upcoming',
                  textScaleFactor: 0.85,
                  style: TextStyle(fontSize: Config.textSize(context, 4)),
                ),
              ),
              Tab(
                child: Text(
                  'Past',
                  textScaleFactor: 0.85,
                  style: appThemeLight.textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushReplacementNamed(context, RouteNames.homePage);
            return Future.value(false);
          },
          child: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: model.allMedications.isEmpty,
                        child: Container(
                          child: Center(
                              child: Text('No Medication for this date')),
                        )),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Config.xMargin(context, 5.0)),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return MedicationCard(
                              height: height,
                              width: width,
                              values: model.medicationReminder[index],
                              drugName: model.medicationReminder[index].drugName,
                              drugType: model.medicationReminder[index].drugType ==
                                  'Injection'
                                  ? "images/injection.png"
                                  : model.medicationReminder[index].drugType ==
                                  'Tablets'
                                  ? "images/tablets.png"
                                  : model.medicationReminder[index].drugType ==
                                  'Drops'
                                  ? "images/drops.png"
                                  : model.medicationReminder[index]
                                  .drugType ==
                                  'Pills'
                                  ? "images/pills.png"
                                  : model.medicationReminder[index]
                                  .drugType ==
                                  'Ointment'
                                  ? "images/ointment.png"
                                  : model.medicationReminder[index]
                                  .drugType ==
                                  'Syrup'
                                  ? "images/syrup.png"
                                  : "images/inhaler.png",
                              time: model.medicationReminder[index].firstTime
                                  .toString(),
                              dosage: model.medicationReminder[index].dosage,
                              selectedFreq: model.medicationReminder[index].frequency,
                            );
                          },
                          itemCount: model.medicationReminder.length,
                        ),
                      ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: model.pastMedications.isEmpty,
                        child: Container(
                          child: Center(child: Text('No Past Medication')),
                        )),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Config.xMargin(context, 5.0)),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return MedicationCard(
                            values: model.medicationReminder[index],
                            drugName: model.medicationReminder[index].drugName,
                            drugType: model.medicationReminder[index].drugType ==
                                'Injection'
                                ? "images/injection.png"
                                : model.medicationReminder[index].drugType ==
                                'Tablets'
                                ? "images/tablets.png"
                                : model.medicationReminder[index].drugType ==
                                'Drops'
                                ? "images/drops.png"
                                : model.medicationReminder[index]
                                .drugType ==
                                'Pills'
                                ? "images/pills.png"
                                : model.medicationReminder[index]
                                .drugType ==
                                'Ointment'
                                ? "images/ointment.png"
                                : model.medicationReminder[index]
                                .drugType ==
                                'Syrup'
                                ? "images/syrup.png"
                                : "images/inhaler.png",
                            time: model.medicationReminder[index].firstTime
                                .toString(),
                            dosage: model.medicationReminder[index].dosage,
                            selectedFreq: model.medicationReminder[index].frequency,
                          );
                        },
                        itemCount: model.medicationReminder.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
