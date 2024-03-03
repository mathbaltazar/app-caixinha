import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextFieldEditorWidget extends StatefulWidget {

  const TextFieldEditorWidget(
      {super.key, this.hint, this.currency = false, this.validation, required this.onConfirm});

  final String? hint;
  final bool currency;
  final String? Function(String)? validation;
  final Function(String) onConfirm;

  @override
  State<TextFieldEditorWidget> createState() => _TextFieldEditorWidgetState();
}

class _TextFieldEditorWidgetState extends State<TextFieldEditorWidget> {
  final controller = TextEditingController(text: '');

  String? _error;

  @override
  Widget build(BuildContext context) {
    if (widget.currency) controller.text = '\$ 0,00';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            errorText: _error,
              label: Text(widget.hint ?? ''),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
          inputFormatters: widget.currency ? [_currencyMask()] : null,
          keyboardType: widget.currency ? TextInputType.number : null,
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {
            if (widget.validation != null) {
              _error = widget.validation!(controller.text.trim());
            }
            if (_error != null) {
              setState(() {});
            } else {
              widget.onConfirm(controller.text.trim());
            }
          },
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
