import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final LocalAuthentication _auth = LocalAuthentication();

// ignore: unused_element
  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    isAvailable ? print('isAvailable') : print('not available');
    return isAvailable;
  }

  Future<void> _availabeBioTypes() async {
    List<BiometricType> listofBiometric;
    try {
      listofBiometric = await _auth.getAvailableBiometrics();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _authUser() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason: "Please authenticate to view your Awaiting Reminders",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    isAuthenticated
        ? print('User is authenticated!')
        : print('User is not authenticated.');
  }
}
