import 'package:MedBuzz/core/constants/route_generator.dart';
import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/core/providers/providers.dart';
import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'core/models/water_reminder_model/water_reminder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(WaterReminderAdapter());
  Hive.registerAdapter(MedicationReminderAdapter());
  Hive.registerAdapter(AppointmentAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MedBuzz',
        theme: appThemeLight,
        initialRoute: RouteNames.addMedicationScreen,
        //Routes now need to be named in the RoutesName class and returned from the generatedRoute function
        //in the RouteGenerator class
        //This update handles page transitions
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
