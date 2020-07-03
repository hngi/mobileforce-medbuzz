import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../size_config/config.dart';

class AddMedicationScreen extends StatefulWidget {
  @override
  _AddMedicationScreenState createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String newIndex = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    var medModel = Provider.of<MedicationData>(context);

    //Fetch current List from Model
    //List<MedicationReminder> allData = medModel.medicationReminder;

    //Select MedicationReminder from List based on id
    // int id = 0;
    // MedicationReminder data = MedicationReminder(
    //     drugName: "Ampicilin", frequency: "once", id: 3, dosage: 3);

    return Scaffold(
      appBar: AppBar(
        leading: medModel.isEditing
            ? IconButton(
                onPressed: () => Navigator.of(context).pop(true),
                icon: Icon(Icons.keyboard_backspace))
            : null,
        title: medModel.isEditing ? titleEdit() : titleAdd(),
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
                  drugTextField(),
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
//                              switch (medModel.currentSelectedValue) {
//                                case 'Once':
//                                  medModel.secondTime = null;
//                                  medModel.thirdTime = null;
//                                  break;
//                                case 'Twice':
//                                  medModel.secondTime = TimeOfDay.now();
//                                  medModel.thirdTime = null;
//                                  break;
//                                case 'Thrice':
//                                  medModel.secondTime = TimeOfDay.now();
//                                  medModel.thirdTime = TimeOfDay.now();
//                                  break;
//                              }
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
                    'Dosage (per day)',
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
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Config.xMargin(context, 4)))),
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
                    onTap: () {
//                      MaterialLocalizations localizations =
//                          MaterialLocalizations.of(context);
//                      print([
//                        localizations.formatMediumDate(medModel.startDate),
//                        localizations.formatMediumDate(medModel.endDate),
//                        medModel.drugName,
//                        medModel.selectedFreq,
//                        medModel.firstTime,
//                        medModel.secondTime,
//                        medModel.thirdTime,
//                        medModel.selectedIndex,
//                        medModel.dosage
//                      ]);
                      if (textEditingController.text.isNotEmpty) {
                        medModel.addMedicationReminder(
                            newIndex,
                            MedicationReminder(
                                drugName: medModel.drugName,
                                drugType:
                                    medModel.drugTypes[medModel.selectedIndex],
                                dosage: medModel.dosage,
                                firstTime: medModel.firstTime,
                                secondTime: medModel.secondTime != null
                                    ? medModel.secondTime
                                    : null,
                                thirdTime: medModel.thirdTime != null
                                    ? medModel.thirdTime
                                    : null,
                                frequency: medModel.selectedFreq,
                                startAt: medModel.startDate,
                                endAt: medModel.endDate));
                      }
                    },
                    child: InkWell(
                      onTap: () async {
                        //Code to insert new schedule
                        MedicationReminder newReminder = MedicationReminder(
                            drugName: medModel.drugName,
                            frequency: medModel.selectedFreq,
                            drugType: medModel.selectedIndex.toString(),
                            dosage: medModel.dosage,
                            firstTime: medModel.firstTime,
                            secondTime: medModel.secondTime,
                            thirdTime: medModel.thirdTime,
                            startAt: medModel.startDate,
                            endAt: medModel.endDate);

                        await medModel.editSchedule(newReminder);
                      },
                      child: Container(
                        height: Config.yMargin(context, 10.0),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Config.yMargin(context, 7)),
          ],
        ),
      ),
    );
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
    textEditingController.text = medModel.isEditing ? medModel.drugName : null;
    return TextFormField(
      //Set initial value is in edit mode

      onFieldSubmitted: (text) {
        medModel.updateDrugName(text);
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
    medModel.isEditing
        ? medModel.onSelectedDrugImage(medModel.selectedIndex)
        : null;
    return GestureDetector(
      onTap: () => medModel.onSelectedDrugImage(index),
      child: Container(
        margin: EdgeInsets.only(right: Config.xMargin(context, 3)),
        height: Config.yMargin(context, 10),
        width: Config.xMargin(context, 18),
        decoration: BoxDecoration(
          color: medModel.selectedIndex == index
              ? Theme.of(context).primaryColor
              : Color(0xffFCEDB8),
          borderRadius:
              BorderRadius.all(Radius.circular(Config.xMargin(context, 10))),
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
                height: Config.yMargin(context, 10.0),
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
                height: Config.yMargin(context, 10.0),
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
                height: Config.yMargin(context, 10.0),
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
                height: Config.yMargin(context, 10.0),
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
                height: Config.yMargin(context, 10.0),
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
                height: Config.yMargin(context, 10.0),
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
                height: Config.yMargin(context, 10.0),
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
                height: Config.yMargin(context, 10.0),
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
