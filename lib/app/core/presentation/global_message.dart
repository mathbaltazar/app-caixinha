import 'package:app_caixinha/app/core/theme/color_schemes.g.dart';
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
      duration: Duration(milliseconds: milliseconds ?? 1000),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: closeIcon,
      closeIconColor: Colors.black87,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon ?? Icons.info, color: Colors.black87),
          const SizedBox(width: 10),
          Text(
            message,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
      elevation: 12,
      backgroundColor: AppColors.darkColorScheme.tertiary.withAlpha(240),
    ));
  }
}
