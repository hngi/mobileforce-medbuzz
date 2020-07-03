import 'package:MedBuzz/ui/views/Home.dart';
import 'package:MedBuzz/ui/views/add_medication/add_medication_screen.dart';
import 'package:MedBuzz/ui/views/all_reminders/all_reminders_screen.dart';
import 'package:MedBuzz/ui/views/diet_reminders/schedule_diet_reminder.dart';
import 'package:MedBuzz/ui/views/drug_description/drug_description.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/add_fitness_screen.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/all_fitness_reminders_screen.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/single_fitness_screen.dart';
import 'package:MedBuzz/ui/views/home_screen/home_page.dart';
import 'package:MedBuzz/ui/views/login_page/login_page_screen.dart';
import 'package:MedBuzz/ui/views/medication_reminders/all_medications_reminder_screen.dart';
import 'package:MedBuzz/ui/views/medication_reminders/medication_reminder_view.dart';
import 'package:MedBuzz/ui/views/onboarding.dart';
import 'package:MedBuzz/ui/views/password_recovery/forgot_password_mail.dart';
import 'package:MedBuzz/ui/views/password_recovery/forgot_password_reset.dart';
import 'package:MedBuzz/ui/views/password_recovery/forgot_password_submit.dart';
import 'package:MedBuzz/ui/views/profile_page.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/all_scheduled_appointment_reminders.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/schedule_appointment_reminder_screen.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/view_appointment_screen.dart';
import 'package:MedBuzz/ui/views/signup_page/signup_screen.dart';
import 'package:MedBuzz/ui/views/single_diet_screen/single_diet_screen.dart';
import 'package:MedBuzz/ui/views/snooze_reminder/confirmation_or_snooze.dart';
import 'package:MedBuzz/ui/views/splash_screen.dart';
import 'package:MedBuzz/ui/views/water_reminders/schedule_water_reminder_screen.dart';
import 'package:MedBuzz/ui/views/water_reminders/water_reminders_view.dart';
import 'package:flutter/material.dart';

class RouteNames {
  ///Custom class that holds all the named routes as constants for easy reference

  static const String splashScreen = '/';
  static const String homePage = 'homePage';
  //Confusing naming 'home' actually is for a screen about Playstore ratings
  static const String home = 'home';
  static const String login = 'login';
  static const String forgotPasswordSubmit = 'forgotPasswordSubmit';
  static const String profile = 'profile';
  static const String onboarding = 'onboarding';
  static const String signup = 'signup';
  static const String drugDescription = 'drugDescription';
  static const String fitnessSchedulesScreen = 'fitnessSchedulesScreen';
  static const String fitnessDescriptionScreen = 'fitnessDescriptionScreen';
  static const String allRemindersScreen = 'allRemindersScreen';
  static const String scheduleAppointmentScreen = 'scheduleAppointmentScreen';
  static const String scheduledAppointmentsPage = 'scheduledAppointmentsPage';
  static const String scheduleWaterReminderScreen = 'schedule-water-reminder';
  static const String waterScheduleView = 'waterScheduleView';
  static const String confirmOrSnoozeReminderScreen =
      'confirmOrSnoozeReminderScreen';
  static const String forgotPasswordReset = 'forgotPasswordReset';
  static const String forgotPasswordMail = 'forgotPasswordMail';
  static const String singleDietScreen = 'singleDietScreen';
  static const String scheduleDietReminderScreen = 'scheduleDietReminderScreen';
  static const String viewAppointmentScreen = 'viewAppointmentScreen';
  static const String singleFitnessScreen = 'singleFitnessScreen';
  static const String medicationView = 'medicationView';
  static const String addMedicationScreen = 'addMedicationScreen';
  static const String medicationScreen = 'medicationScreen';

//Brought routes here to  clean things up in the main.dart file
  static Map<String, Widget Function(BuildContext)> routes = {
    RouteNames.splashScreen: (context) => SplashScreen(),
    RouteNames.home: (context) => HomeScreen(),
    RouteNames.login: (context) => LoginPage(),
    RouteNames.forgotPasswordSubmit: (context) => ForgotPasswordSubmit(),
    RouteNames.profile: (context) => ProfilePage(),
    RouteNames.onboarding: (context) => Onboard(),
    RouteNames.homePage: (context) => HomePage(),
    RouteNames.signup: (context) => Signup(),
    RouteNames.allRemindersScreen: (context) => AllRemindersScreen(),
    RouteNames.drugDescription: (context) => DrugDescription(),
    RouteNames.fitnessSchedulesScreen: (context) => FitnessSchedulesScreen(),
    RouteNames.fitnessDescriptionScreen: (context) =>
        FitnessDescriptionScreen(),
    RouteNames.scheduleAppointmentScreen: (context) =>
        ScheduleAppointmentScreen(),
    RouteNames.scheduledAppointmentsPage: (context) =>
        ScheduledAppointmentsPage(),
    RouteNames.scheduleWaterReminderScreen: (context) =>
        ScheduleWaterReminderScreen(),
    RouteNames.waterScheduleView: (context) => WaterScheduleViewScreen(),
    RouteNames.confirmOrSnoozeReminderScreen: (context) =>
        ConfirmOrSnoozeScreen(),
    RouteNames.forgotPasswordReset: (context) => ForgotPasswordReset(),
    RouteNames.forgotPasswordMail: (context) => ForgotPasswordMail(),
    RouteNames.singleDietScreen: (context) => SingleDiet(),
    RouteNames.scheduleDietReminderScreen: (context) =>
        ScheduleDietReminderScreen(),
    RouteNames.viewAppointmentScreen: (context) => ViewAppointment(),
    RouteNames.singleFitnessScreen: (context) => SingleFitnessScreen(),
    RouteNames.medicationView: (context) => MedicationView(),
    RouteNames.addMedicationScreen: (context) => AddMedicationScreen(),
    RouteNames.medicationScreen: (context) => MedicationScreen(),
  };
}
