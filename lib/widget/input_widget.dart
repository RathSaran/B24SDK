import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Widget label;
  final Widget? suffixIcon;
  final double height;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final String? initValue;
  const InputWidget({
    super.key,
    required this.label,
    this.suffixIcon,
    required this.controller,
    this.validator,
    required this.onChanged,
    this.initValue,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: suffixIcon,
            label: label),
        validator: validator,
        onChanged: onChanged,
        initialValue: initValue,
      ),
    );
  }
}
