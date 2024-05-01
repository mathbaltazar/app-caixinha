import 'package:flutter/material.dart';

class GlobalMessage {
  static GlobalKey<ScaffoldMessengerState>? _messenger;

  static GlobalKey<ScaffoldMessengerState> instance(BuildContext context) {
    return _messenger ??= GlobalKey();
  }

  static show(String message, {int? milliseconds, IconData? icon, bool? closeIcon}) {
    if (_messenger?.currentState == null) {
      throw 'Scaffold messenger not initialized';
    }
    _messenger!.currentState!.showSnackBar(SnackBar(
      duration: Duration(milliseconds: milliseconds ?? 2000),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: closeIcon,
      closeIconColor: Colors.white,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon ?? Icons.info, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
      elevation: 12,
    ));
  }
}
