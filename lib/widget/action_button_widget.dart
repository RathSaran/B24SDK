import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

class ActionButtonWidget extends StatelessWidget {
   final VoidCallback callback;
  final String imageName;
  final Color color;

 const ActionButtonWidget({
    Key? key,
    required this.imageName,required this.color,required this.callback}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:callback,
      child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:color,
              borderRadius: BorderRadius.circular(8)
            ),
            // child:  SvgPicture.asset(imageName,width: 20,height: 20,),
          ),
    );
       
  
  }
}