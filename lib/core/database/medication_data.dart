import 'package:MedBuzz/ui/views/add_medication/add_medication_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:hive/hive.dart';
import 'dart:math';

class MedicationData extends ChangeNotifier {
  static const String _boxName = "medicationReminderBox";
  final String add = "Add Medication";
  final String edit = "Edit Medication";

  final List drugTypes = [
    'injection',
    'tablets',
    'drops',
    'pills',
    'ointment',
    'syrup',
    'inhaler'
  ];

  final List<String> frequency = ['Once', 'Twice', 'Thrice'];
  var selectedFreq = 'Once';
  int selectedIndex = 0;
  String selectedDrugType = 'images/injection.png';
  int dosage = 1;
  TimeOfDay firstTime = TimeOfDay.now();
  TimeOfDay secondTime;
  TimeOfDay thirdTime;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String drugName;
  String id;
  String description = "Enter Anything Here";

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

  MedicationReminder getSchedule() {
    print("first print - ${this.firstTime}");
    MedicationReminder schedule = MedicationReminder(
        id: this.id,
        firstTime: convertTime(this.firstTime),
        // secondTime:
        //     this.secondTime != null ? convertTime(this.secondTime) : null,
        // thirdTime: this.thirdTime != null ? convertTime(this.thirdTime) : null,
        frequency: this.selectedFreq);
    print(this.firstTime);
    print("Trying to create schedule");

    return schedule;
  }

  void newMedicine(BuildContext context) {
    //Clear the fields in model
    resetModelFields();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddMedicationScreen()));
  }

  List<MedicationReminder> medicationReminder = [];

  List<int> convertTime(TimeOfDay time) {
    List<int> value = new List(2);
    value[0] = time.hour;
    value[1] = time.minute;

    return value;
  }

  String updateDescription(String value) {
    this.description = value;
    notifyListeners();
    return description;
  }

  String updateSelectedDrugType(String drugType) {
    this.selectedDrugType = drugType == images[0]
        ? images[0]
        : drugType == images[1]
            ? images[1]
            : drugType == images[2]
                ? images[2]
                : drugType == images[3]
                    ? images[3]
                    : drugType == images[4]
                        ? images[4]
                        : drugType == images[5] ? images[5] : images[6];

    return selectedDrugType;
  }

  bool resetModelFields() {
    this.selectedDrugType = 'images/injection.png';
    this.selectedFreq = 'Once';
    this.selectedIndex = 0;
    this.dosage = 1;
    this.firstTime = TimeOfDay.now();
    this.secondTime = null;
    this.thirdTime = null;
    this.startDate = DateTime.now();
    this.endDate = DateTime.now();
    this.drugName = null;
    this.id = null;
    this.description = null;
    this.isEditing = false;
    return true;
  }

  Future<void> fetch() async {
    getMedicationReminder();
    notifyListeners();
  }

  TimeOfDay convertTimeBack(List<int> list) {
    TimeOfDay value = TimeOfDay(hour: list[0], minute: list[1]);
    return value;
  }

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

  TimeOfDay updateFirstTime(TimeOfDay selectedTime) {
    this.firstTime = selectedTime;
    notifyListeners();
    return firstTime;
  }

  TimeOfDay updateSecondTime(TimeOfDay selectedTime) {
    this.secondTime = selectedTime;
    notifyListeners();
    return secondTime;
  }

  TimeOfDay updateThirdTime(TimeOfDay selectedTime) {
    this.thirdTime = selectedTime;
    notifyListeners();
    return thirdTime;
  }

  String updateFrequency(String freq) {
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
    return selectedFreq;
  }

  String updateFreq(String freq) {
    this.selectedFreq = freq;
    notifyListeners();
    return selectedFreq;
  }

  int updateSelectedIndex(int index) {
    this.selectedIndex = index;
    notifyListeners();
    return this.selectedIndex;
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

  String updateId(String newId) {
    id = newId;
    notifyListeners();
    return id;
  }

  int updateDosage(int newDosage) {
    dosage = newDosage;
    notifyListeners();
    return dosage;
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

  Future<void> addMedicationReminder(MedicationReminder medication) async {
    var medicationReminderBox =
        await Hive.openBox<MedicationReminder>(_boxName);

    await medicationReminderBox.put(medication.id.toString(), medication);

    medicationReminder = medicationReminderBox.values.toList();
    medicationReminderBox.close();

    notifyListeners();
  }

  Future<void> editSchedule({MedicationReminder medication}) async {
    String medicationKey = medication.id;
    var medicationReminderBox =
        await Hive.openBox<MedicationReminder>(_boxName);
    await medicationReminderBox.put(medicationKey, medication);

    medicationReminder = medicationReminderBox.values.toList();
    // medicationReminderBox.close();

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
