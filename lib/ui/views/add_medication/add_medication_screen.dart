import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:MedBuzz/core/notifications/drug_notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../size_config/config.dart';

class AddMedicationScreen extends StatefulWidget {
  final String payload;

  const AddMedicationScreen({Key key, this.payload}) : super(key: key);
  @override
  _AddMedicationScreenState createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  //var medModel = Provider.of<MedicationData>(context);

  FocusNode _focusNode = FocusNode();
  String newIndex = DateTime.now().toString();
  bool _changed_name = false;
  bool _changed_description = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      //Get updated data from database
      Provider.of<MedicationData>(context).getMedicationReminder();
    });
  }

  @override
  Widget build(BuildContext context) {
    var medModel = Provider.of<MedicationData>(context);
    String appBarTitle = medModel.isEditing ? medModel.edit : medModel.add;
    if (medModel.isEditing && _changed_name == false) {
      textEditingController.text = medModel.drugName;
      _changed_name = true;
    }
    if (medModel.isEditing && _changed_description == false) {
      descriptionTextController.text = medModel.description;
      _changed_description = true;
    }

    return Scaffold(
      appBar: AppBar(
        leading: medModel.isEditing
            ? IconButton(
                onPressed: () => Navigator.of(context).pop(true),
                icon: Icon(Icons.keyboard_backspace))
            : null,
        title: Text(
          appBarTitle,
          style: Theme.of(context)
              .textTheme
              .headline6 //REMOVED THE 6
              .copyWith(
                color: Theme.of(context).primaryColorDark,
              ),
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 1.0,
      ),
      body: Container(
        color: Theme.of(context).primaryColorLight,
        child: ListView(
          addRepaintBoundaries: false,
          children: <Widget>[
            SizedBox(height: Config.yMargin(context, 3)),
            Container(
              padding: EdgeInsets.fromLTRB(
                Config.xMargin(context, 5),
                Config.xMargin(context, 0),
                Config.xMargin(context, 5),
                0.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Drug Name',
                    style: TextStyle(
                        fontSize: Config.textSize(context, 5),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Config.yMargin(context, 1.5)),
                  TextField(
                    controller: textEditingController,
                    focusNode: _focusNode,
                    cursorColor: Theme.of(context).primaryColorDark,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: Config.xMargin(context, 5.5)),
                    decoration: InputDecoration(
                      hintText: 'Aspirin',
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: Config.xMargin(context, 5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Config.xMargin(context, 5))),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Config.xMargin(context, 5))),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                  ),
                  SizedBox(height: Config.yMargin(context, 2.5)),
                  Text(
                    'Description',
                    style: TextStyle(
                        fontSize: Config.textSize(context, 5),
                        fontWeight: FontWeight.bold),
                  ),
                  //Description Text Input
                  SizedBox(height: Config.yMargin(context, 1.5)),
                  TextField(
                    maxLines: null,
                    controller: descriptionTextController,
                    cursorColor: Theme.of(context).primaryColorDark,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: Config.xMargin(context, 5.5)),
                    decoration: InputDecoration(
                      hintText: 'Enter Description here',
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: Config.xMargin(context, 5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Config.xMargin(context, 5))),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Config.xMargin(context, 5))),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: Config.yMargin(context, 6)),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: medModel.images
            //       .asMap()
            //       .entries
            //       .map((MapEntry map) => buildImageContainer(map.key))
            //       .toList(),
            // ),
            Container(
              padding: EdgeInsets.fromLTRB(
                Config.xMargin(context, 5),
                Config.xMargin(context, 0),
                Config.xMargin(context, 5),
                0.0,
              ),
              height: Config.yMargin(context, 10.0),
              child: ListView.builder(
                padding: EdgeInsets.only(left: Config.xMargin(context, 0)),
                scrollDirection: Axis.horizontal,
                itemCount: medModel.drugTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildImageContainer(index);
                },
              ),
            ),
            SizedBox(height: Config.yMargin(context, 6)),
            Container(
              padding: EdgeInsets.fromLTRB(
                Config.xMargin(context, 5),
                Config.xMargin(context, 0),
                Config.xMargin(context, 5),
                0.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Reminder Frequency',
                    style: TextStyle(
                        fontSize: Config.textSize(context, 5),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Config.yMargin(context, 1.5)),
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          hintText: '${medModel.frequency}',
                          hintStyle: TextStyle(
                            color: Colors.black38,
                            fontSize: Config.xMargin(context, 5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                Config.xMargin(context, 5),
                              ),
                            ),
                          ),
                        ),
                        isEmpty: false,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: Config.xMargin(context, 8),
                            ),
                            value: medModel.selectedFreq,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                medModel.selectedFreq = newValue;
                                state.didChange(newValue);
                              });
                              medModel.updateFrequency(newValue);
                            },
                            items: medModel.frequency.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: Config.yMargin(context, 6)),
                  Text(
                    'Set time to take medication',
                    style: TextStyle(
                        fontSize: Config.textSize(context, 5),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Config.yMargin(context, 3.0)),
                  medModel.selectedFreq == 'Once'
                      ? buildRowOnce()
                      : medModel.selectedFreq == 'Twice'
                          ? buildRowTwice()
                          : buildRowThrice(),
                  SizedBox(height: Config.yMargin(context, 6.0)),
                  Text(
                    'Dosage',
                    style: TextStyle(
                        fontSize: Config.textSize(context, 5),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Config.yMargin(context, 3.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => medModel.decreaseDosage(),
                        child: Container(
                          height: Config.yMargin(context, 4.5),
                          width: Config.xMargin(context, 8.3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              color: Theme.of(context).primaryColorLight,
                              size: Config.xMargin(context, 5),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '${medModel.dosage}',
                        style: TextStyle(
                            fontSize: Config.textSize(context, 5),
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => medModel.increaseDosage(),
                        child: Container(
                          height: Config.yMargin(context, 4.5),
                          width: Config.xMargin(context, 8.3),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Config.xMargin(context, 4)))),
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColorLight,
                            size: Config.xMargin(context, 5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Config.yMargin(context, 6.0)),
                  Text(
                    'Duration',
                    style: TextStyle(
                        fontSize: Config.textSize(context, 5),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Config.yMargin(context, 3.0)),
                  buildStartDate(),
                  SizedBox(height: Config.yMargin(context, 1.5)),
                  buildEndDate(),
                  SizedBox(height: Config.yMargin(context, 10)),
                  InkWell(
                      onTap: () async {
                        if (textEditingController.text.isNotEmpty) {
                          switch (appBarTitle) {
                            case 'Add Medication':
                              print(medModel.updateDescription(
                                  descriptionTextController.text));
                              //Add Medication? create new MedicationReminder with new ID
                              MedicationReminder med = MedicationReminder(
                                  id: DateTime.now().toString(),
                                  drugName: medModel.updateDrugName(
                                      textEditingController.text),
                                  drugType: medModel
                                      .drugTypes[medModel.selectedIndex],
                                  dosage: medModel.dosage,
                                  firstTime: [
                                    medModel.firstTime.hour,
                                    medModel.firstTime.minute
                                  ],
                                  secondTime: medModel.secondTime != null
                                      ? [
                                          medModel.secondTime.hour,
                                          medModel.secondTime.minute
                                        ]
                                      : [],
                                  thirdTime: medModel.thirdTime != null
                                      ? [
                                          medModel.thirdTime.hour,
                                          medModel.thirdTime.minute
                                        ]
                                      : [],
                                  frequency: medModel.selectedFreq,
                                  startAt: medModel.startDate,
                                  endAt: medModel.endDate,
                                  description: medModel.description,
                                  index: medModel.selectedIndex.toString());

                              await medModel.addMedicationReminder(med);
                              switch (medModel.selectedFreq) {
                                case 'Once':
                                  setNotification(med, med.firstTime);
                                  break;
                                case 'Twice':
                                  setNotification(med, med.firstTime);
                                  setNotification(med, med.secondTime);
                                  break;
                                case 'Thrice':
                                  setNotification(med, med.firstTime);
                                  setNotification(med, med.secondTime);
                                  setNotification(med, med.thirdTime);
                                  break;
                              }

                              break;
                            // work here on your editing schedule code
                            case 'Edit Medication':
                              print(medModel
                                  .updateDrugName(textEditingController.text));
                              print(medModel.updateDescription(
                                  descriptionTextController.text));

                              print(medModel.drugTypes[medModel.selectedIndex]);

                              print(medModel.dosage);
                              print([
                                medModel.firstTime.hour,
                                medModel.firstTime.minute
                              ]);
                              print(medModel.secondTime != null
                                  ? [
                                      medModel.secondTime.hour,
                                      medModel.secondTime.minute
                                    ]
                                  : 'second Time: null');

                              print(medModel.thirdTime != null
                                  ? [
                                      medModel.thirdTime.hour,
                                      medModel.thirdTime.minute
                                    ]
                                  : "ThirdTime: null");
                              print(medModel.selectedFreq);
                              print(medModel.startDate);
                              print(medModel.endDate);

                              MedicationReminder newReminder =
                                  MedicationReminder(
                                      drugName: medModel.drugName,
                                      id: medModel.id,
                                      drugType: medModel
                                          .drugTypes[medModel.selectedIndex],
                                      dosage: medModel.dosage,
                                      firstTime: [
                                        medModel.firstTime.hour,
                                        medModel.firstTime.minute
                                      ],
                                      secondTime: medModel.secondTime != null
                                          ? [
                                              medModel.secondTime.hour,
                                              medModel.secondTime.minute
                                            ]
                                          : [],
                                      thirdTime: medModel.thirdTime != null
                                          ? [
                                              medModel.thirdTime.hour,
                                              medModel.thirdTime.minute
                                            ]
                                          : [],
                                      frequency: medModel.selectedFreq,
                                      startAt: medModel.startDate,
                                      endAt: medModel.endDate,
                                      index: medModel.selectedIndex.toString(),
                                      description: medModel.description);

                              //Put newReminder in database
                              await medModel.editSchedule(
                                  medication: newReminder);

                              print("Saving editted schedule");
                              //Delete previous Notifications
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

                              //create new Notifications
                              switch (medModel.selectedFreq) {
                                case 'Once':
                                  setNotification(
                                      newReminder, newReminder.firstTime);
                                  break;
                                case 'Twice':
                                  setNotification(
                                      newReminder, newReminder.firstTime);
                                  setNotification(
                                      newReminder, newReminder.secondTime);
                                  break;
                                case 'Thrice':
                                  setNotification(
                                      newReminder, newReminder.firstTime);
                                  setNotification(
                                      newReminder, newReminder.secondTime);
                                  setNotification(
                                      newReminder, newReminder.thirdTime);
                                  break;
                              }

                              break;
                          }
                          Navigator.popAndPushNamed(
                              context, RouteNames.medicationScreen);
                        } else {
                          //TODO display SnackBar to notify that name is empty
                        }
                      },
                      child: Container(
                        height: Config.yMargin(context, 8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Config.xMargin(context, 3.5))),
                            color: Theme.of(context).primaryColor),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: Config.textSize(context, 4.5),
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),

            SizedBox(height: Config.yMargin(context, 7)),
          ],
        ),
      ),
    );
  }

//Function to set notification
  void setNotification(MedicationReminder med, List<int> time) {
    //notification id has to be unique so using the the id provided in the model and the time supplied
    // should work just fine
    DateTime date = DateTime.parse(med.id);
    int id =
        num.parse('${date.year}${date.month}${date.day}${time[0]}${time[1]}');

    DrugNotificationManager notificationManager = DrugNotificationManager();
    notificationManager.showDrugNotificationDaily(
        hour: time[0],
        minute: time[1],
        id: id,
        //username can be replaced with the actual name of the user
        title: "Hey (username)!",
        body:
            "It's time to take ${med.dosage} ${med.drugType} of ${med.drugName}");
  }

  void deleteNotification(MedicationReminder med, List<int> time) {
    DateTime date = DateTime.parse(med.id);
    int id =
        num.parse('${date.year}${date.month}${date.day}${time[0]}${time[1]}');

    var notificationManager = DrugNotificationManager();
    notificationManager.removeReminder(id);
  }

  Widget titleAdd() {
    return Text(
      'Add Medication',
      style: Theme.of(context)
          .textTheme
          .headline6 //REMOVED THE 6
          .copyWith(
            color: Theme.of(context).primaryColorDark,
          ),
    );
  }

  Widget titleEdit() {
    return Text(
      'Edit Medication',
      style: Theme.of(context)
          .textTheme
          .headline6 //REMOVED THE 6
          .copyWith(
            color: Theme.of(context).primaryColorDark,
          ),
    );
  }

  Widget drugTextField() {
    var medModel = Provider.of<MedicationData>(context);
    return TextFormField(
      onChanged: (val) {
        textEditingController.text = val;
      },
      onFieldSubmitted: (text) {
        medModel.updateDrugName(textEditingController.text);
      },
      focusNode: _focusNode,
      onTap: () {},
      controller: textEditingController,
      cursorColor: Theme.of(context).primaryColorDark,
      style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontSize: Config.xMargin(context, 5.5)),
      decoration: InputDecoration(
        hintText: 'Metronidazole',
        hintStyle: TextStyle(
          color: Colors.black38,
          fontSize: Config.xMargin(context, 5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Config.xMargin(context, 5))),
          borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
        ),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Config.xMargin(context, 5))),
          borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
        ),
      ),
    );
  }

  Widget buildImageContainer(int index) {
    var medModel = Provider.of<MedicationData>(context);

    return GestureDetector(
      onTap: () {
        medModel.onSelectedDrugImage(index);
        print(medModel.updateSelectedIndex(index));
      },
      child: Container(
        padding: EdgeInsets.all(Config.xMargin(context, 1.5)),
        margin: EdgeInsets.only(right: Config.xMargin(context, 3)),
        height: Config.yMargin(context, 10),
        width: Config.xMargin(context, 18),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: medModel.selectedIndex == index
              ? Theme.of(context).primaryColor
              : Color(0xffFCEDB8),
        ),
        child: Image(
          image: AssetImage(medModel.images[index]),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget buildRowOnce() {
    var medModel = Provider.of<MedicationData>(context);
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              localizations.formatTimeOfDay(medModel.firstTime),
              style: TextStyle(
                fontSize: Config.textSize(context, 4.5),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
              splashColor: Theme.of(context).buttonColor,
              onTap: () async {
                final TimeOfDay selectedTime = await showTimePicker(
                  context: context,
                  initialTime: medModel.firstTime,
                );
                if (selectedTime != null) {
                  medModel.updateFirstTime(selectedTime);
                }
                if (medModel.firstTime == TimeOfDay.now()) {
                  return null;
                }
              },
              child: Container(
                height: Config.yMargin(context, 8.0),
                width: Config.xMargin(context, 26.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Config.xMargin(context, 3.5))),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 4.5),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildRowTwice() {
    var medModel = Provider.of<MedicationData>(context);
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              localizations.formatTimeOfDay(medModel.firstTime),
              style: TextStyle(
                fontSize: Config.textSize(context, 4.5),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
              onTap: () async {
                final TimeOfDay selectedTime = await showTimePicker(
                  context: context,
                  initialTime: medModel.firstTime,
                );
                if (selectedTime != null) {
                  medModel.updateFirstTime(selectedTime);
                }
              },
              child: Container(
                height: Config.yMargin(context, 8.0),
                width: Config.xMargin(context, 26.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Config.xMargin(context, 3.5))),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 4.5),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: Config.yMargin(context, 1.5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              localizations.formatTimeOfDay(medModel.secondTime),
              style: TextStyle(
                fontSize: Config.textSize(context, 4.5),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
              onTap: () async {
                final TimeOfDay selectedTime = await showTimePicker(
                  context: context,
                  initialTime: medModel.secondTime,
                );
                if (selectedTime != null) {
                  medModel.updateSecondTime(selectedTime);
                }
              },
              child: Container(
                height: Config.yMargin(context, 8.0),
                width: Config.xMargin(context, 26.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Config.xMargin(context, 3.5))),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 4.5),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildRowThrice() {
    var medModel = Provider.of<MedicationData>(context);
    //medModel.thirdTime = TimeOfDay.now();
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              localizations.formatTimeOfDay(medModel.firstTime),
              style: TextStyle(
                fontSize: Config.textSize(context, 4.5),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
              onTap: () async {
                final TimeOfDay selectedTime = await showTimePicker(
                  context: context,
                  initialTime: medModel.firstTime,
                );
                if (selectedTime != null) {
                  medModel.updateFirstTime(selectedTime);
                }
              },
              child: Container(
                height: Config.yMargin(context, 8.0),
                width: Config.xMargin(context, 26.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Config.xMargin(context, 3.5))),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 4.5),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: Config.yMargin(context, 1.5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              localizations.formatTimeOfDay(medModel.secondTime),
              style: TextStyle(
                fontSize: Config.textSize(context, 4.5),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
              onTap: () async {
                final TimeOfDay selectedTime = await showTimePicker(
                  context: context,
                  initialTime: medModel.secondTime,
                );
                if (selectedTime != null) {
                  medModel.updateSecondTime(selectedTime);
                }
              },
              child: Container(
                height: Config.yMargin(context, 8.0),
                width: Config.xMargin(context, 26.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Config.xMargin(context, 3.5))),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 4.5),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: Config.yMargin(context, 1.5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              localizations.formatTimeOfDay(medModel.thirdTime),
              style: TextStyle(
                fontSize: Config.textSize(context, 4.5),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
              onTap: () async {
                final TimeOfDay selectedTime = await showTimePicker(
                  context: context,
                  initialTime: medModel.thirdTime,
                );
                if (selectedTime != null) {
                  medModel.updateThirdTime(selectedTime);
                }
              },
              child: Container(
                height: Config.yMargin(context, 8.0),
                width: Config.xMargin(context, 26.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Config.xMargin(context, 3.5))),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 4.5),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildStartDate() {
    var medModel = Provider.of<MedicationData>(context);
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Start - ${localizations.formatMediumDate(medModel.startDate)}',
              style: TextStyle(
                fontSize: Config.textSize(context, 4.5),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
              onTap: () async {
                final DateTime selectedTime = await showDatePicker(
                  firstDate: DateTime(medModel.startDate.year),
                  lastDate: DateTime(medModel.startDate.year + 1),
                  context: context,
                  initialDate: medModel.startDate,
                );
                if (selectedTime != null) {
                  medModel.updateStartDate(selectedTime);
                }
              },
              child: Container(
                height: Config.yMargin(context, 8.0),
                width: Config.xMargin(context, 26.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Config.xMargin(context, 3.5))),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 4.5),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildEndDate() {
    var medModel = Provider.of<MedicationData>(context);
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'End - ${localizations.formatMediumDate(medModel.endDate)}',
              style: TextStyle(
                fontSize: Config.textSize(context, 4.5),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
              onTap: () async {
                final DateTime selectedTime = await showDatePicker(
                  firstDate: DateTime(medModel.endDate.year),
                  lastDate: DateTime(medModel.endDate.year + 1),
                  context: context,
                  initialDate: medModel.endDate,
                );
                if (selectedTime != null) {
                  medModel.updateEndDate(selectedTime);
                }
              },
              child: Container(
                height: Config.yMargin(context, 8.0),
                width: Config.xMargin(context, 26.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Config.xMargin(context, 3.5))),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 4.5),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
