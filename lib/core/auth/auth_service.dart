import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final LocalAuthentication _auth = LocalAuthentication();

// ignore: unused_element
  Future<void> isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    isAvailable ? print('isAvailable') : print('not available');
    return isAvailable;
  }

  Future<void> availabeBioTypes() async {
    List<BiometricType> listofBiometric = List<BiometricType>();
    try {
      listofBiometric = await _auth.getAvailableBiometrics();
    } catch (e) {
      print(e.toString());
    }
    print(listofBiometric.toString());
  }

  Future<void> authUser(context) async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason: "Please authenticate to view your Awaiting Reminders",
        useErrorDialogs: true,
        stickyAuth: false,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    isAuthenticated
        ? Navigator.pushReplacementNamed(context, RouteNames.homePage)
        : print('User is not authenticated.');
  }
}
