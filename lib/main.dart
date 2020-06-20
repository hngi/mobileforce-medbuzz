import 'package:MedBuzz/core/providers/providers.dart';
import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:MedBuzz/ui/views/Home.dart';
import 'package:MedBuzz/ui/views/profile_page.dart';
import 'package:MedBuzz/ui/views/splash_screen.dart';
import 'package:MedBuzz/ui/views/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          '/' : (context) => SplashScreen(),
          'home': (context) => HomeScreen(),
          'profile': (context) => ProfilePage() 
        },
      ),
    );
  }
}

