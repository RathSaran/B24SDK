import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final String label;
  final TextInputType inputType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final Widget? pastIcon;

  InputTextWidget(
      {required this.label,
      required this.inputType,
      required this.controller,
      required this.validator,
      required this.onChanged,
      required this.pastIcon});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: pastIcon,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label),
                const Icon(
                  Icons.star,
                  size: 10,
                  color: Colors.red,
                )
              ],
            )),
        keyboardType: inputType,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
