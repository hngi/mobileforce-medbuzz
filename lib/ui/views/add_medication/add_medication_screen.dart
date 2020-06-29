import 'package:MedBuzz/ui/views/add_medication/add_medication_model.dart';
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
  @override
  Widget build(BuildContext context) {
    var medModel = Provider.of<AddMedication>(context);
    return Scaffold(
      appBar: AppBar(
        leading: medModel.isEditing ? Icon(Icons.keyboard_backspace) : null,
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
                padding: EdgeInsets.only(left: Config.xMargin(context, 5)),
                scrollDirection: Axis.horizontal,
                itemCount: medModel.drugType.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildImageContainer(index);
                },
              ),
            ),
            SizedBox(height: Config.yMargin(context, 6)),
            Container(
              child: Column(
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
                          hintText: 'Once',
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
                            value: medModel.currentSelectedValue,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                medModel.currentSelectedValue = newValue;
                                state.didChange(newValue);
                              });
                              switch (medModel.currentSelectedValue) {
                                case 'Once':
                                  medModel.secondTime = null;
                                  medModel.thirdTime = null;
                                  break;
                                case 'Twice':
                                  medModel.secondTime = TimeOfDay.now();
                                  medModel.thirdTime = null;
                                  break;
                                case 'Thrice':
                                  medModel.secondTime = TimeOfDay.now();
                                  medModel.thirdTime = TimeOfDay.now();
                                  break;
                              }
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
                  medModel.currentSelectedValue == 'Once'
                      ? buildRowOnce()
                      : medModel.currentSelectedValue == 'Twice'
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
                        onTap: () => medModel.incrementCounter(),
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
                      Text(
                        '${medModel.dosage}',
                        style: TextStyle(
                            fontSize: Config.textSize(context, 5),
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => medModel.decrementCounter(),
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
                      MaterialLocalizations localizations =
                          MaterialLocalizations.of(context);
                      print([
                        localizations.formatMediumDate(medModel.startTime),
                        localizations.formatMediumDate(medModel.endTime),
                        medModel.drugName,
                        medModel.currentSelectedValue,
                        medModel.firstTime,
                        medModel.secondTime,
                        medModel.thirdTime,
                        medModel.selectedIndex,
                        medModel.dosage
                      ]);
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
    var medModel = Provider.of<AddMedication>(context);
    return TextFormField(
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
    var medModel = Provider.of<AddMedication>(context);
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
    var medModel = Provider.of<AddMedication>(context);
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
                  initialTime: TimeOfDay.now(),
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
    var medModel = Provider.of<AddMedication>(context);
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
    var medModel = Provider.of<AddMedication>(context);
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
    var medModel = Provider.of<AddMedication>(context);
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Start - ${localizations.formatMediumDate(medModel.startTime)}',
              style: TextStyle(
                fontSize: Config.textSize(context, 4.5),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
              onTap: () async {
                final DateTime selectedTime = await showDatePicker(
                  firstDate: DateTime(medModel.startTime.year),
                  lastDate: DateTime(medModel.startTime.year + 1),
                  context: context,
                  initialDate: medModel.startTime,
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
    var medModel = Provider.of<AddMedication>(context);
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'End - ${localizations.formatMediumDate(medModel.endTime)}',
              style: TextStyle(
                fontSize: Config.textSize(context, 4.5),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
              onTap: () async {
                final DateTime selectedTime = await showDatePicker(
                  firstDate: DateTime(medModel.endTime.year),
                  lastDate: DateTime(medModel.endTime.year + 1),
                  context: context,
                  initialDate: medModel.endTime,
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
