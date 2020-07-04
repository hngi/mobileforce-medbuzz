import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/ui/navigation/page_transition/page_transition.dart';
import 'package:MedBuzz/ui/views/Home.dart';
import 'package:MedBuzz/ui/views/add_medication/add_medication_screen.dart';
import 'package:MedBuzz/ui/views/all_reminders/all_reminders_screen.dart';
import 'package:MedBuzz/ui/views/diet_reminders/all_diet_reminders.dart';
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
import 'package:MedBuzz/ui/views/water_reminders/single_water_screen.dart';
import 'package:MedBuzz/ui/views/water_reminders/water_reminders_view.dart';
import 'package:MedBuzz/ui/widget/delete_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return CustomSlideTransition(child: SplashScreen());
        break;
      case RouteNames.homePage:
        return CustomSlideTransition(child: HomePage());
        break;
      case RouteNames.home:
        return CustomSlideTransition(child: HomeScreen());
        break;
      case RouteNames.login:
        return CustomSlideTransition(child: LoginPage());
        break;
      case RouteNames.forgotPasswordSubmit:
        return CustomSlideTransition(child: ForgotPasswordSubmit());
        break;
      case RouteNames.profile:
        return CustomSlideTransition(child: ProfilePage());
        break;
      case RouteNames.onboarding:
        return CustomSlideTransition(child: Onboard());
        break;
      case RouteNames.signup:
        return CustomSlideTransition(child: Signup());
        break;
      case RouteNames.allRemindersScreen:
        return CustomSlideTransition(child: AllRemindersScreen());
        break;
      case RouteNames.drugDescription:
        return CustomSlideTransition(child: DrugDescription());
        break;
      case RouteNames.fitnessSchedulesScreen:
        return CustomSlideTransition(child: FitnessSchedulesScreen());
        break;
      case RouteNames.fitnessDescriptionScreen:
        return CustomSlideTransition(child: FitnessDescriptionScreen());
        break;
      case RouteNames.scheduleAppointmentScreen:
        return CustomSlideTransition(child: ScheduleAppointmentScreen());
        break;
      case RouteNames.scheduledAppointmentsPage:
        return CustomSlideTransition(child: ScheduledAppointmentsPage());
        break;
      case RouteNames.scheduleWaterReminderScreen:
        return CustomSlideTransition(child: ScheduleWaterReminderScreen());
        break;
      case RouteNames.waterScheduleView:
        return CustomSlideTransition(child: WaterScheduleViewScreen());
        break;
      case RouteNames.confirmOrSnoozeReminderScreen:
        return CustomSlideTransition(child: ConfirmOrSnoozeScreen());
        break;
      case RouteNames.forgotPasswordReset:
        return CustomSlideTransition(child: ForgotPasswordReset());
        break;
      case RouteNames.forgotPasswordMail:
        return CustomSlideTransition(child: ForgotPasswordMail());
        break;
      case RouteNames.singleDietScreen:
        return CustomSlideTransition(child: SingleDiet());
        break;
      case RouteNames.viewAppointmentScreen:
        return CustomSlideTransition(child: ViewAppointment());
        break;
      case RouteNames.scheduleDietReminderScreen:
        return CustomSlideTransition(child: ScheduleDietReminderScreen());
        break;
      case RouteNames.singleFitnessScreen:
        return CustomSlideTransition(child: SingleFitnessScreen());
        break;
      case RouteNames.medicationView:
        return CustomSlideTransition(child: MedicationView());
        break;
      case RouteNames.addMedicationScreen:
        return CustomSlideTransition(child: AddMedicationScreen());
        break;
      case RouteNames.medicationScreen:
        return CustomSlideTransition(child: MedicationScreen());
        break;
      case RouteNames.dietScheduleScreen:
        return CustomSlideTransition(child: DietScheduleScreen());
        break;
      case RouteNames.singleWater:
        return CustomSlideTransition(child: SingleWater());
        break;
      case RouteNames.deleteDialog:
        return CustomSlideTransition(child: DeleteDialog());
        break;
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CustomSlideTransition(
      child: Scaffold(
          appBar: AppBar(
              title: Text(
            'Page not found',
            style: TextStyle(color: Colors.red),
          )),
          body: Center(
            child: Text(
              'Error! Page not found',
              style: TextStyle(color: Colors.red),
            ),
          )),
    );
  }
}
