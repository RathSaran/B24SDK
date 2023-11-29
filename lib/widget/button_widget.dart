import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color color;
  final String name;
  final VoidCallback callback;
  

  ButtonWidget({required this.color,required this.name,required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 50,
        padding:const  EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Text(name,style:const TextStyle(color: Colors.white),),
      ),
    );
  }
}