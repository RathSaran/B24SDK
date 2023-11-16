
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_merchant_app_flutter/const/constant.dart';
import 'package:sample_merchant_app_flutter/widget/button_widget.dart';
import 'package:sample_merchant_app_flutter/widget/input_text_widget.dart';
import 'package:b24_payment_sdk/b24_payment_sdk.dart';

enum ThemeMode{darkMode,lightMode}
enum Language{km,en}


class HomeScreen extends StatefulWidget {
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _transactionNoController=TextEditingController();
  final _refererKeyController=TextEditingController();

  ThemeMode? _themeMode=ThemeMode.lightMode;
  Language? _language=Language.km;

  bool darkMode=false;
  String language="km";
  bool production=false;


//   String _message="Unknown Messsage";
//   static const platform=MethodChannel("merchant-sample.com/native");

//  Future<void> _getSDK(String tranNo,String refererKey,String lang,bool isDarkMode,bool isProduction) async{
//   String messageFromNativeCode;

//   try{
//     messageFromNativeCode=await platform.invokeMethod("getSDK",{
//       'tranNo':tranNo,
//       'refererKey':refererKey,
//       'language':lang,
//       'darkMode':isDarkMode,
//       'production':isProduction
//     });
//   } on PlatformException catch(ex){
//     messageFromNativeCode="Failed to load message: ${ex.message}";
//   }
//   setState(() {
//     _message=messageFromNativeCode;
//   });
// }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Merchant App"),
        actions: [
          Container(
            padding:const EdgeInsets.only(right: 15),
            alignment: Alignment.centerRight,
            child: const Text(Constant.version,style: TextStyle(fontStyle: FontStyle.italic),),
          )
         
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:const EdgeInsets.all(15),
          child: Column(
            children: [
              //transaction no
              InputTextWidget(
                label: "transaction no", 
                inputType: TextInputType.text, 
                controller: _transactionNoController),
              const SizedBox(height: 10,),
              //referer key
              InputTextWidget(
                label: "referer key", 
                inputType: TextInputType.text, 
                controller: _refererKeyController),
      
              //theme mode 
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Radio<ThemeMode>(
                        value: ThemeMode.lightMode,
                        groupValue: _themeMode,
                        onChanged: (value){
                          setState(() {
                            _themeMode=value;
                            darkMode=false;
                          });
                        },
                      ),
                      const Text("Light Mode")
                        ],
                      ),
                      Row(
                        children: [
                          Radio<ThemeMode>(
                        value: ThemeMode.darkMode,
                        groupValue: _themeMode,
                        onChanged: (value){
                          setState(() {
                            _themeMode=value;
                            darkMode=true;
                          });
                        },
                      ),
                      const Text("Dark Mode")
                        ],
                      )
                    ],
                  ),
                ),
      
                //language
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Radio<Language>(
                        value: Language.km,
                        groupValue: _language,
                        onChanged: (value){
                          setState(() {
                            _language=value;
                            language="km";
                          });
                        },
                      ),
                      const Text("Khmer")
                        ],
                      ),
                      Row(
                        children: [
                          Radio<Language>(
                        value: Language.en,
                        groupValue: _language,
                        onChanged: (value){
                          setState(() {
                            _language=value;
                            language="en";
                          });
                        },
                      ),
                      const Text("English")
                        ],
                      )
                    ],
                  ),
                ),
      
            const SizedBox(height: 10,),

            Row(
              children: [
                   Checkbox(
                    value: production, 
                    onChanged: (value){
                      setState(() {
                        production=value!;
                      });
                    }),

                  const Text("Production")
            
              ],
            ),
           
           
            //load sdk
            ButtonWidget(
              color: Colors.green, 
              name: "Init Sdk", 
              callback: (){


                //invoke native
                // _getSDK(
                //   _transactionNoController.text == "" ? "BEDCBDCA55AC":_transactionNoController.text,
                //    _refererKeyController.text == "" ? "123X":_refererKeyController.text,
                //   language,
                //   darkMode,
                //   production);
            

                   //to invoke to native
                  

                  //for call in flutter
                
                   B24PaymentSdk.intSdk(
                  controller: (context), 
                  tranId: _transactionNoController.text == ""? "BEDCBDCA55AC":_transactionNoController.text, 
                  refererKey: _refererKeyController.text  == ""?"123X":_refererKeyController.text,
                  darkMode: darkMode,
                  language: language,
                  isProduction: production
                  );
              }

               
              

                 
                
      
              )
      
            ],
          ),
        ),
      ),
    );
  }
}