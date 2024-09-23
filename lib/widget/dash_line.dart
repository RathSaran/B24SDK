import 'package:flutter/material.dart';

class DashLineWidget extends StatelessWidget {
  final double height;
  final Color color;

  const DashLineWidget({
    Key? key,
    this.height=1,this.color=Colors.black,ke}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_){
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color)
                  ),
              );
          })
          );
      }
      );
  }
}