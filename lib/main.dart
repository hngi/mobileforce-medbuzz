import 'package:MedBuzz/core/providers/providers.dart';
import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:MedBuzz/ui/views/Home.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/all_fitness_reminders_screen.dart';
import 'package:MedBuzz/ui/views/onboarding.dart';
import 'package:MedBuzz/ui/views/profile_page.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/schedule_appointment_reminder_screen.dart';
import 'package:MedBuzz/ui/views/splash_screen.dart';
import 'package:MedBuzz/ui/views/home_page.dart';
import 'package:MedBuzz/ui/views/login_page/login_page_screen.dart';
import 'package:MedBuzz/ui/views/water_reminders/schedule_water_reminder_screen.dart';
import 'package:MedBuzz/ui/views/signup_page/signup_screen.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/all_scheduled_appointment_reminders.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/views/signup_page/signup_screen.dart';
import 'ui/views/water_reminders/water_reminders_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MedBuzz',
        theme: appThemeLight,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          'home': (context) => HomeScreen(),
          'login': (context) => LoginPage(),
          'profile': (context) => ProfilePage(),
          'onboarding': (context) => Onboard(),
          'homepage': (context) => HomePage(),
          'signup': (context) => Signup(),
          'FitnessSchedulesScreen': (context) => FitnessSchedulesScreen(),
          'ScheduleAppointmentScreen': (context) => ScheduleAppointmentScreen(),
          'ScheduledAppointmentsPage': (context) => ScheduledAppointmentsPage(),
          WaterScheduleScreen.routeName: (context) => WaterScheduleScreen(),
          'waterScheduleView': (context) => WaterScheduleViewScreen(),
        },
      ),
    );
  }
}
