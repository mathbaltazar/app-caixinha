import 'package:flutter/material.dart';

class GlobalMessage {
  static GlobalKey<ScaffoldMessengerState>? _messenger;

  static GlobalKey<ScaffoldMessengerState> instance(BuildContext context) {
    return _messenger ??= GlobalKey();
  }

  static show(String message, [int? duration]) {
    if (_messenger?.currentState == null) {
      throw 'Scaffold messenger not initialized';
    }
    _messenger!.currentState!.showSnackBar(SnackBar(
      duration: Duration(seconds: duration ?? 1),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      elevation: 12,
    ));
  }
}