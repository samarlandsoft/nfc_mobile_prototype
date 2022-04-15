import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SaltInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final int? maxSymbols;
  final double? maxHeight;
  final double? maxWidth;
  final TextInputAction action;
  final bool withCapitalization;

  const SaltInputField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.maxSymbols,
    this.maxHeight = 56.0,
    this.maxWidth,
    this.action = TextInputAction.next,
    this.withCapitalization = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxHeight,
      width: maxWidth,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          filled: true,
          errorMaxLines: 1,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE7E8EB)),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE7E8EB)),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.withOpacity(0.5)),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        inputFormatters: [
          if (maxSymbols != null)
            LengthLimitingTextFieldFormatterFixed(maxSymbols!),
          if (withCapitalization) UpperCaseTextFormatter(),
        ],
        maxLength: maxSymbols,
        maxLines: 1,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}

class LengthLimitingTextFieldFormatterFixed
    extends LengthLimitingTextInputFormatter {
  LengthLimitingTextFieldFormatterFixed(int maxLength) : super(maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength != null &&
        maxLength! > 0 &&
        newValue.text.characters.length > maxLength!) {
      if (oldValue.text.characters.length == maxLength) {
        return oldValue;
      }
      return LengthLimitingTextInputFormatter.truncate(newValue, maxLength!);
    }
    return newValue;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
