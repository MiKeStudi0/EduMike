import 'package:edumike/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeTextField extends StatelessWidget {
  final Alignment? alignment;
  final BuildContext context;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Function(String) onChanged;
  final FormFieldValidator<String>? validator;

  const CustomPinCodeTextField({
    super.key,
    required this.context,
    required this.onChanged,
    this.alignment,
    this.controller,
    this.textStyle,
    this.hintStyle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: PinCodeTextFieldWidget(),
          )
        : PinCodeTextFieldWidget();
  }

  Widget PinCodeTextFieldWidget() {
    return PinCodeTextField(
      appContext: context,
      controller: controller,
      length: 4,
      keyboardType: TextInputType.phone,
      textStyle: textStyle,
      hintStyle: hintStyle,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10.0),
        borderWidth: 2, // Add border width for better visibility
        inactiveColor:
            appTheme.blue600, // Set inactive color to grey for visibility
        activeColor: const Color.fromARGB(0, 52, 116, 245),
        selectedColor: const Color.fromARGB(0, 69, 184, 237),
      ),
      onChanged: (value) => onChanged(value),
      validator: validator,
    );
  }
}
