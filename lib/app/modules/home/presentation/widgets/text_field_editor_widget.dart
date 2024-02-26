import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextFieldEditorWidget extends StatelessWidget {
  TextFieldEditorWidget(
      {super.key, required this.onConfirm, this.hint, this.currency = false});

  final controller = TextEditingController(text: '');
  final String? hint;
  final bool currency;
  final Function(String) onConfirm;

  @override
  Widget build(BuildContext context) {
    if (currency) controller.text = '\$ 0,00';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
              label: Text(hint ?? ''),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
          inputFormatters: currency ? [_currencyMask()] : null,
          keyboardType: currency ? TextInputType.number : null,
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () => onConfirm(controller.text.trim()),
          icon: const Icon(Icons.check_circle),
          label: const Text('Confirmar'),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  static TextInputFormatter _currencyMask() => TextInputFormatter.withFunction(
        (oldValue, TextEditingValue newValue) {
      String onlyDigits = newValue.text.replaceAll(RegExp('[^0-9]'), '');
      String formatted = _formatter.format((double.parse(onlyDigits) / 100)).trim();
      return TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length));
    });

  static final _formatter =
      NumberFormat.currency(locale: Platform.localeName, symbol: '\$');
}
