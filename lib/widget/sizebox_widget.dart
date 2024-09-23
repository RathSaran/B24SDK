import 'package:flutter/material.dart';

class SizeboxWidget extends StatelessWidget {
  final double width;
  final double height;
  const SizeboxWidget({super.key, this.width = 0, this.height = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
