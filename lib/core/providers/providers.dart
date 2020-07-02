import 'package:MedBuzz/ui/views/add_medication/add_medication_model.dart';
import 'package:MedBuzz/ui/views/all_reminders/all_reminders_view_model.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/all_fitness_reminders_model.dart';
import 'package:MedBuzz/ui/views/diet_reminders/diet_reminders_model.dart';
import 'package:MedBuzz/ui/views/home_screen/home_screen_model.dart';
import 'package:MedBuzz/ui/views/snooze_reminder/confirmation_or_snooze_model.dart';
import 'package:MedBuzz/ui/views/water_reminders/schedule_water_reminder_model.dart';
import 'package:provider/provider.dart';

import '../database/waterReminderData.dart';

//Add your view models in this widget

final providers = <SingleChildCloneableWidget>[
  ChangeNotifierProvider(create: (_) => FitnessSchedulesModel()),
  ChangeNotifierProvider(create: (_) => ConfirmOrSnoozeModel()),
  ChangeNotifierProvider(create: (_) => DietReminderModel()),
  ChangeNotifierProvider(create: (_) => AddMedication()),
  ChangeNotifierProvider(create: (_) => ScheduleWaterReminderViewModel()),
  ChangeNotifierProvider(create: (_) => AllRemindersViewModel()),
  ChangeNotifierProvider(create: (_) => HomeScreenModel()),
  ChangeNotifierProvider(create: (_) => WaterReminderData()),
];

//final dietProviders = <SingleChildCloneableWidget>[
//
//];
