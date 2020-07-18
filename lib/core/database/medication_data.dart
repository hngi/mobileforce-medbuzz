import 'package:MedBuzz/core/database/medication_history.dart';
import 'package:MedBuzz/core/models/medication_history_model/medication_history.dart';
import 'package:MedBuzz/core/notifications/drug_notification_manager.dart';
import 'package:MedBuzz/ui/views/add_medication/add_medication_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:hive/hive.dart';
import 'dart:math';

import 'package:provider/provider.dart';

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
  MedicationReminder reminder;
  MedicationHistory newHistory;
  BuildContext context;

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

  MedicationReminder setReminder(MedicationReminder val) {
    this.reminder = val;
    notifyListeners();
    return this.reminder;
  }

  void newMedicine(BuildContext context) {
    //Clear the fields in model
    resetModelFields();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddMedicationScreen()));
  }

  List<MedicationReminder> medicationReminder = [];

  List<MedicationReminder> get allMedications {
    return medicationReminder;
  }

//  List<MedicationReminder> get pastReminders {
//    return medicationReminder.where((element) => element.endAt.isBefore(DateTime.now())).toList();
//
//  }
  List<MedicationReminder> get myPastMedication {
    return medicationReminder
        .where((element) => _selectedDay.day > element.endAt.day)
        .toList();
  }

  List<MedicationReminder> get pastReminders {
    return medicationReminder
        .where((element) => DateTime.now().difference(element.endAt).inDays > 0)
        .toList();
  }

  void deleteAllMedicationSchedule() {
    for (var medication in pastReminders) {
      deleteSchedule(medication.id);
    }
  }

  void updateAvailableMedicationReminder(medicationReminders) {
    medicationReminder = medicationReminders;
    notifyListeners();
  }

  List<MedicationReminder> get pastMedications {
    return medicationReminder
        .where((medication) => _selectedDay.day > medication.endAt.day)
        .toList();
  }

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

  MedicationHistory convertReminderToHistory(MedicationReminder reminder) {
    MedicationHistory history = MedicationHistory(
      drugName: reminder.drugName,
      drugType: reminder.drugType,
      dosage: reminder.dosage,
      frequency: reminder.frequency,
      firstTime: reminder.firstTime,
      secondTime: reminder.secondTime,
      thirdTime: reminder.thirdTime,
      startAt: reminder.startAt,
      endAt: reminder.endAt,
      id: reminder.id,
      index: reminder.index,
      description: reminder.description,
    );
    return history;
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

    //Magic to remove Schedule from db if schedule is outdated
    List<MedicationReminder> temp = medicationReminderBox.values.toList();

    temp.removeWhere((element) {
      DateTime now = DateTime.now();
      DateTime endDate = element.endAt;

      DateTime endDateWithHourAndMin;
      //Magic to add hour and minute to Element.endDate and assign to
      switch (element.frequency) {
        case 'Once':
          endDateWithHourAndMin = DateTime.utc(endDate.year, endDate.month,
              endDate.day, element.firstTime[0], element.firstTime[1]);
          break;
        case 'Twice':
          List<int> latestTime;
          //Code to check which time is the latest time
          if (element.secondTime[0] > element.firstTime[0]) {
            latestTime = element.secondTime;
          } else if (element.secondTime[0] == element.firstTime[0]) {
            if (element.secondTime[1] >= element.firstTime[1]) {
              latestTime = element.secondTime;
            } else {
              latestTime = element.firstTime;
            }
          } else {
            latestTime = element.firstTime;
          }

          endDateWithHourAndMin = DateTime.utc(endDate.year, endDate.month,
              endDate.day, latestTime[0], latestTime[1]);
          break;
        case 'Thrice':
          List<int> latest;
          int first =
              num.parse('${element.firstTime[0]}${element.firstTime[1]}');
          int second =
              num.parse('${element.secondTime[0]}${element.secondTime[1]}');
          int third =
              num.parse('${element.thirdTime[0]}${element.thirdTime[1]}');

          latest = first > second
              ? first > third ? element.firstTime : element.thirdTime
              : second > third ? element.secondTime : element.thirdTime;

          endDateWithHourAndMin = DateTime.utc(
              endDate.year, endDate.month, endDate.day, latest[0], latest[1]);
          break;
        default:
          throw Exception(
              "Could not get frequency to use to add Hour & Minute");
      }

      //Code to make outdated schedule wait an hour before being deleted.
      //So that notification can be seen before schedule is deleted
      endDateWithHourAndMin = endDateWithHourAndMin.add(Duration(hours: 1));

      bool boolean = now
          .isAfter(endDateWithHourAndMin); //if true then schedule is outdated

      if (boolean) {
        //code to add Outdated Medication Reminder to History db before deleting
        if (newHistory == null) {
          this.newHistory = convertReminderToHistory(element);
        }

        //delete outdated schedule from medication database
        addHistoryAndDelete(element.id);
        print('Deleting outdated Schedule: ${element.drugName}');
        print('Deleting its notifications');
        switch (element.frequency) {
          case 'Once':
            deleteNotification(element, element.firstTime);
            break;
          case 'Twice':
            deleteNotification(element, element.firstTime);
            deleteNotification(element, element.secondTime);
            break;
          case 'Thrice':
            deleteNotification(element, element.firstTime);
            deleteNotification(element, element.secondTime);
            deleteNotification(element, element.thirdTime);
            break;
        }
      }

      return (boolean);
    });

    //--End of Magic
    // print(temp);
    medicationReminder = temp;
    notifyListeners();
  }

  void deleteNotification(MedicationReminder med, List<int> time) {
    DateTime date = DateTime.parse(med.id);
    int temp = num.parse('${date.month}${date.day}${time[0]}${time[1]}');
    int secondTemp = num.parse('${date.year}0000');
    int id = temp - secondTemp;

    DrugNotificationManager notificationManager = DrugNotificationManager();
    notificationManager.removeReminder(id);
    print("Deleted Notification of id $id");
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
    // medicationReminderBox.close();

    notifyListeners();
  }

  void addHistoryAndDelete(key) async {
    var medicationReminderBox =
        await Hive.openBox<MedicationReminder>(_boxName);

    medicationReminder = medicationReminderBox.values.toList();
    await medicationReminderBox.delete(key);
    // medicationReminderBox.close();
    await addMedicationReminderHistory(this.newHistory);
    this.newHistory = null;

    notifyListeners();
  }

  Future<void> addMedicationReminderHistory(MedicationHistory history) async {
    var box = await Hive.openBox<MedicationHistory>("medicationHistoryBox");

    await box.put(history.id.toString(), history);
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
