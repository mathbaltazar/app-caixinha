import 'package:flutter/services.dart';

import 'text_utils.dart';

class TextfieldInputMask {
  static TextInputFormatter currencyMask() =>
      TextInputFormatter.withFunction((oldValue, TextEditingValue newValue) {
        String onlyDigits = newValue.text.replaceAll(RegExp('[^0-9]'), '');
        String formatted =
            TextUtils.formatCurrency((double.parse(onlyDigits) / 100)).trim();
        return TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length));
      });
}
