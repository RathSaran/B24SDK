import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void pasteText(TextEditingController controller) async {
  ClipboardData? clipboardData = await Clipboard.getData('text/plain');
  if (clipboardData != null) {
    controller.text = clipboardData.text!;
  }
}
