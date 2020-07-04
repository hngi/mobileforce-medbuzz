import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:hive/hive.dart';
import 'dart:math';

class MedicationData extends ChangeNotifier {
  static const String _boxName = "medicationReminderBox";

  final List drugTypes = [
    'Injection',
    'Tablets',
    'Drops',
    'Pills',
    'Ointment',
    'Syrup',
    'Inhaler'
  ];

  final List<String> frequency = ['Once', 'Twice', 'Thrice'];
  var selectedFreq = 'Once';
  int selectedIndex = 0;
  int dosage = 1;
  TimeOfDay firstTime = TimeOfDay.now();
  TimeOfDay secondTime = TimeOfDay.now();
  TimeOfDay thirdTime = TimeOfDay.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String drugName;

  bool isEditing = false;

  List<String> images = [
    'images/injection.png',
    'images/tablets.png',
    'images/drops.png',
    'images/pills.png',
    'images/ointment.png',
    'images/syrup.png',
    'images/inhaler.png'
  ];

  List<MedicationReminder> medicationReminder = [];

  void onSelectedDrugImage(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  int getUniqueId(TimeOfDay time) {
    return int.parse(
        '${time.hour}${time.minute}${this.medicationReminder.length}${Random().nextInt(90) + 1}');
  }

  String medicationDescription(MedicationReminder medication) {
    String medicationDescription;
    switch (medication.drugType) {
      case 'Injection':
        if (medication.dosage == 1) {
          medicationDescription =
              '${medication.dosage} shot ${medication.frequency.toLowerCase()} daily';
        } else {
          medicationDescription =
              '${medication.dosage} shots ${medication.frequency.toLowerCase()} daily';
        }
        break;
      default:
        if (medication.dosage == 1) {
          medicationDescription =
              '${medication.dosage} ${medication.drugType.toLowerCase()} ${medication.frequency.toLowerCase()} daily';
        } else {
          medicationDescription =
              '${medication.dosage} ${medication.drugType.toLowerCase()}s ${medication.frequency.toLowerCase()} daily';
        }
    }
    return medicationDescription;
  }

  bool isToday() {
    return this.startDate.difference(DateTime.now()) == 0;
  }

  int drugsLeft(MedicationReminder medication) {
    int drugsLeft;
    int daysLeft = MedicationData().diffFromPresent(medication.endAt);
    if (daysLeft ==
        MedicationData().daysTotal(medication.startAt, medication.endAt)) {
      drugsLeft = MedicationData().totalQuantityOfDrugs(medication);
    } else {
      drugsLeft = MedicationData().totalQuantityOfDrugs(medication) -
          MedicationData().totalQuantityOfDrugs(medication, overRide: daysLeft);
    }
    return drugsLeft;
  }

  void updateStartDate(DateTime selectedDate) {
    this.startDate = selectedDate;
    notifyListeners();
  }

  void updateEndDate(DateTime selectedDate) {
    this.endDate = selectedDate;
    notifyListeners();
  }

  void updateFirstTime(TimeOfDay selectedTime) {
    this.firstTime = selectedTime;
    notifyListeners();
  }

  void updateSecondTime(TimeOfDay selectedTime) {
    this.secondTime = selectedTime;
    notifyListeners();
  }

  void updateThirdTime(TimeOfDay selectedTime) {
    this.thirdTime = selectedTime;
    notifyListeners();
  }

  void updateFrequency(String freq) {
    this.selectedFreq = freq;
    switch (freq) {
      case 'Once':
        this.secondTime = null;
        this.thirdTime = null;
        break;
      case 'Twice':
        this.secondTime = TimeOfDay.now();
        this.thirdTime = null;
        break;
      case 'Thrice':
        this.secondTime = TimeOfDay.now();
        this.thirdTime = TimeOfDay.now();
        break;
    }
    notifyListeners();
  }

  void updateSelectedIndex(int index) {
    this.selectedIndex = index;
    notifyListeners();
  }

  void increaseDosage() {
    this.dosage++;
    notifyListeners();
  }

  void decreaseDosage() {
    if (this.dosage > 1) {
      this.dosage--;
      notifyListeners();
    }
  }

  String updateDrugName(String name) {
    drugName = name;
    notifyListeners();
    return drugName;
  }

  int diffFromPresent(DateTime end) {
    var difference = DateTime.now().difference(end);
    return difference.inDays.abs();
  }

  int daysTotal(DateTime start, DateTime end) {
    var difference = end.difference(start);
    return difference.inDays;
  }

  int totalQuantityOfDrugs(MedicationReminder medication, {int overRide}) {
    int numOfDays =
        MedicationData().daysTotal(medication.startAt, medication.endAt) != 0
            ? MedicationData().daysTotal(medication.startAt, medication.endAt)
            : 1;
    if (overRide != null) {
      numOfDays = overRide;
    }
    int total;
    switch (medication.frequency) {
      case 'Once':
        total = medication.dosage * numOfDays;
        break;
      case 'Twice':
        total = 2 * medication.dosage * numOfDays;
        break;
      case 'Thrice':
        total = 3 * medication.dosage * numOfDays;
        break;
    }
    return total;
  }

  void getMedicationReminder() async {
    var medicationReminderBox =
        await Hive.openBox<MedicationReminder>(_boxName);

    medicationReminder = medicationReminderBox.values.toList();
    notifyListeners();
  }

  Future<void> addMedicationReminder(
      String index, MedicationReminder medication) async {
    var medicationReminderBox =
        await Hive.openBox<MedicationReminder>(_boxName);

    await medicationReminderBox.put(index, medication);

    medicationReminder = medicationReminderBox.values.toList();
    medicationReminderBox.close();

    notifyListeners();
  }

  Future<void> editSchedule({MedicationReminder medication}) async {
    String medicationKey = medication.index;
    var medicationReminderBox =
        await Hive.openBox<MedicationReminder>(_boxName);
    await medicationReminderBox.put(medicationKey, medication);

    medicationReminder = medicationReminderBox.values.toList();
    medicationReminderBox.close();

    notifyListeners();
  }

  void deleteSchedule(key) async {
    var medicationReminderBox =
        await Hive.openBox<MedicationReminder>(_boxName);

    medicationReminder = medicationReminderBox.values.toList();
    medicationReminderBox.delete(key);
    medicationReminderBox.close();

    notifyListeners();
  }

  //model for all medication screen
  bool isVisible = true;
  bool isExpanded = false;
  DateTime _selectedDay = DateTime.now();

  //functionality for making the FAB appear and disappear when user scrolls
  void updateVisibility(bool visible) {
    this.isVisible = visible;
    notifyListeners();
  }

  void expandTile(bool changed) {
    this.isExpanded = !isExpanded;
    notifyListeners();
  }

  //Retrieve data from DB

  //Get name of weekday
  String getWeekday(DateTime date) {
    return date.weekday == 1
        ? 'Mon'
        : date.weekday == 2
            ? 'Tue'
            : date.weekday == 3
                ? 'Wed'
                : date.weekday == 4
                    ? 'Thur'
                    : date.weekday == 5
                        ? 'Fri'
                        : date.weekday == 6 ? 'Sat' : 'Sun';
  }

  //Button color for selected day is different from others
//Selected day is DateTime.now().day by default
  Color getButtonColor(BuildContext context, DateTime date) {
    return date.day == _selectedDay.day
        ? Theme.of(context).buttonColor
        : Colors.grey[200];
  }

  //Text color changes depending on the button color
  Color getTextColor(BuildContext context, DateTime date) {
    return date.day == _selectedDay.day
        ? Theme.of(context).primaryColorLight
        : Theme.of(context).primaryColorDark;
  }

  //Toggles date displayed on the screen
  void changeDay(DateTime date) {
    this._selectedDay = date;
    notifyListeners();
  }
}
