
import 'package:flutter/foundation.dart';

class AppError extends FlutterError {

  AppError(String message) : super(message);

  // Called in FlutterError.reportError(details);
  static FlutterExceptionHandler onError = dumpErrorToServer;


  static void dumpErrorToServer(FlutterErrorDetails details, { bool forceReport: false }) {

    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
  }


  static void reportError(FlutterErrorDetails details) {

    FlutterError.reportError(details);
  }
}