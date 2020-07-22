import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';

class AppointmentData extends ChangeNotifier {
  static const String _boxName = "appointmentBox";

  DateTime appointmentMonth = DateTime.now();
  DateTime appointmentDay = DateTime.now();
  DateTime appointmentTime = DateTime.now();
  String appointmentSubject;
  String appointmentNote;
  Appointment _currentAppointment;

  Appointment get currentAppointment => _currentAppointment;

  bool isEditing = false;

  List<Appointment> _appointment = [];
  List<Appointment> _sortedAppointment = [];

  List<Appointment> get appointment => _appointment;
  List<Appointment> get sortedAppointment => _sortedAppointment;

  Appointment _activeAppointment;

  //get all the appointments
  void getAppointments() async {
    var box = await Hive.openBox<Appointment>(_boxName);

    _appointment = box.values.toList();

    notifyListeners();
  }

  //get a particular appointment
  void getAppointment(key) async {
    var box = await Hive.openBox<Appointment>(_boxName);
    this._currentAppointment = box.get(key);
    notifyListeners();
  }

  Future<void> addAppointment(Appointment appointment) async {
    var box = await Hive.openBox<Appointment>(_boxName);

    await box.put(appointment.id, appointment);

    _appointment = box.values.toList();
    box.close();
    notifyListeners();
  }

  String get typeOfAppointment => appointmentSubject;

  setSelectedTypeOfAppointment(String typeOfAppointment) =>
      appointmentSubject = typeOfAppointment;

  String get note => appointmentNote;

  setSelectedNote(String note) => appointmentNote = note;

  Future<void> deleteAppointment(key) async {
    var box = await Hive.openBox<Appointment>(_boxName);

    _appointment = box.values.toList();
    box.delete(key);
    box.close();

    notifyListeners();
  }

  Future<void> editAppointment({Appointment appointment}) async {
    String appointmentKey = appointment.id;
    var box = await Hive.openBox<Appointment>(_boxName);

    await box.put(appointmentKey, appointment);

    _appointment = box.values.toList();

// _activeAppointment = box.get(appointmentKey);

    notifyListeners();
  }

  void setActiveAppointment(key) async {
    var box = await Hive.openBox<Appointment>(_boxName);

    _activeAppointment = box.get(key);

    notifyListeners();
  }

  void deleteAppointmentReminders() async {
    try {
      var box = await Hive.openBox<Appointment>(_boxName);
      box.deleteFromDisk();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Appointment getActiveAppointment() {
    return _activeAppointment;
  }

  int get appointmentCount {
    return _appointment.length;
  }
}
