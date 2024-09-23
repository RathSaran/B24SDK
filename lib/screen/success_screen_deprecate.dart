import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:sample_merchant_app_flutter/const/constant.dart';
import 'package:sample_merchant_app_flutter/widget/action_button_widget.dart';
import 'package:sample_merchant_app_flutter/widget/dash_line.dart';
import 'package:sample_merchant_app_flutter/widget/button_widget.dart';

class SuccessScreenDeprecate extends StatelessWidget {
  const SuccessScreenDeprecate({super.key});

  _buildRow(String title ,String value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            //background
            Container(
              decoration:const BoxDecoration(
                  color: Colors.amber
              ),
            ) ,
            //invoice card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Container(
                  padding:const EdgeInsets.all(20) ,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10)
                    ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    // SvgPicture.asset("assets/success_icon.svg",width: 75,height: 75,),
                    const SizedBox(height: 20,),
                    const Text(Constant.invoiceAlreadyPaid),
                   const SizedBox(height: 20,),
                    DashLineWidget(height: 1,color: Colors.black.withOpacity(0.4),),
                     const SizedBox(height: 20,),
                    _buildRow(Constant.invoiceNo, "Invoice No"),
                    const SizedBox(height: 10,),
                    _buildRow(Constant.bankRef, "Bank Ref"),
                    const SizedBox(height: 10,),
                    _buildRow(Constant.toMerchant, "To Merchant"),
                    const SizedBox(height: 10,),
                    _buildRow(Constant.tranDate, "value"),
                    const SizedBox(height: 20,),
                    DashLineWidget(height: 1,color: Colors.black.withOpacity(0.4),),
                    const SizedBox(height: 20,),
                    _buildRow(Constant.total, "Total"),
                    const SizedBox(height: 20,),
                    DashLineWidget(height: 1,color: Colors.black.withOpacity(0.4),),
                    const SizedBox(height: 20,),
                  //action button share download
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          ActionButtonWidget(
                            callback: () {
                              
                            },
                            imageName: "assets/download.svg", 
                            color: Colors.green
                            ),
                          const SizedBox(width: 30,),
                          ActionButtonWidget(
                            callback: () {
                              
                            },
                            imageName: "assets/upload.svg",
                             color: Colors.green)

                      ],
                    ),
                    const SizedBox(height: 20,),

                    //done button
                    ButtonWidget(
                      color: Colors.green, 
                      name:Constant.done, 
                      callback: (){
                        //print("button click");

                      })
                    
            
                  ]),
                ),
              ),
            )
          ],
        )
      ,
      ),
    );
  }
}