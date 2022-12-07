import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

void cprint(dynamic data, {String? errorIn, String? event, String label = 'Log'}) {
  /// Print logs only in development mode
  if (kDebugMode) {
    if (errorIn != null) {
      print(
          '****************************** error ******************************');
      developer.log('[Error]', time: DateTime.now(), error: data, name: errorIn);
      print(
          '****************************** error ******************************');
    } else if (data != null) {
      developer.log(data, time: DateTime.now(), name: label);
    }

  }
}