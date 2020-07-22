import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final LocalAuthentication _auth = LocalAuthentication();

// ignore: unused_element
  Future<bool> isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e.toString());
    }

    isAvailable ? print('is Available') : print('not available');
    return isAvailable;
  }

  Future<void> availableBioTypes() async {
    List<BiometricType> listOfBiometric = List<BiometricType>();
    try {
      listOfBiometric = await _auth.getAvailableBiometrics();
    } catch (e) {
      print(e.toString());
    }
    print(listOfBiometric.toString());
  }

  Future<void> authUser(context) async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason: "Please authenticate to your sign in",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    isAuthenticated
        ? Navigator.pushReplacementNamed(context, RouteNames.homePage)
        : print('User is not authenticated.');

    return isAuthenticated;
  }

  Future<void> authSession() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason: "Please authenticate to start MedBuzz",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    isAuthenticated
        ? print('User is authenticated.')
        : print('User is not authenticated.');
  }
}
