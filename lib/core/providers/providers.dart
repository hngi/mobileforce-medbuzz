import 'package:MedBuzz/ui/views/add_medication/add_medication_model.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/all_fitness_reminders_model.dart';
import 'package:MedBuzz/ui/views/water_reminders/schedule_water_reminder_model.dart';
import 'package:MedBuzz/ui/views/medication_reminders/all_medications_reminder_model.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/schedule_appointment_screen_model.dart';
import 'package:provider/provider.dart';

//Add your view models in this widget

final providers = <SingleChildCloneableWidget>[
  ChangeNotifierProvider(create: (_) => FitnessSchedulesModel()),
  ChangeNotifierProvider(create: (_) => WaterReminderViewModel()),
  ChangeNotifierProvider(create: (_) => ScheduleAppointmentModel()),
  ChangeNotifierProvider(create: (_) => AddMedication()),
  ChangeNotifierProvider(create: (_) => MedicationsSchedulesModel())
];
