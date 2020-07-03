import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/core/database/waterReminderData.dart';
import 'package:MedBuzz/ui/views/all_reminders/all_reminders_view_model.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/all_fitness_reminders_model.dart';
import 'package:MedBuzz/ui/views/diet_reminders/diet_reminders_model.dart';
import 'package:MedBuzz/ui/views/home_screen/home_screen_model.dart';
import 'package:MedBuzz/ui/views/medication_reminders/all_medications_reminder_model.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/schedule_appointment_screen_model.dart';
import 'package:MedBuzz/ui/views/snooze_reminder/confirmation_or_snooze_model.dart';
import 'package:MedBuzz/ui/views/water_reminders/schedule_water_reminder_model.dart';
import 'package:provider/provider.dart';

//Add your view models in this widget

final providers = <SingleChildCloneableWidget>[
  ChangeNotifierProvider(create: (_) => FitnessSchedulesModel()),
  ChangeNotifierProvider(create: (_) => ConfirmOrSnoozeModel()),
  ChangeNotifierProvider(create: (_) => DietReminderModel()),
  ChangeNotifierProvider(create: (_) => ScheduleWaterReminderViewModel()),
  ChangeNotifierProvider(create: (_) => AllRemindersViewModel()),
  ChangeNotifierProvider(create: (_) => MedicationData()),
  ChangeNotifierProvider(create: (_) => HomeScreenModel()),
  ChangeNotifierProvider(create: (_) => WaterReminderData()),
  ChangeNotifierProvider(create: (_) => ScheduleAppointmentModel()),
  ChangeNotifierProvider(create: (_) => MedicationsSchedulesModel()),
];

//final dietProviders = <SingleChildCloneableWidget>[
//
//];
