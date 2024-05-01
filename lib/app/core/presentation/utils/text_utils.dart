import 'dart:io';

import 'package:intl/intl.dart';

class TextUtils {

  static final _formatter =
  NumberFormat.currency(locale: Platform.localeName, symbol: '');

  static String formatCurrency(double? currency) {
    return _formatter.format(currency);
  }

  static double? parseCurrency(String text) {
    return _formatter.tryParse(text)?.toDouble();
  }
}