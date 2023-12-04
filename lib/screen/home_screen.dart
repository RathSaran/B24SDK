import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sample_merchant_app_flutter/widget/button_widget.dart';
import 'package:sample_merchant_app_flutter/widget/input_text_widget.dart';
import 'package:b24_payment_sdk/b24_payment_sdk.dart';

enum ThemeMode { darkMode, lightMode }

enum Language { km, en }

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _transactionNoController = TextEditingController();
  final _refererKeyController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _inputText = '';

  String? _validateInputText(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'Please input $field';
    }
  }

  ThemeMode? _themeMode = ThemeMode.lightMode;
  Language? _language = Language.km;

  bool darkMode = false;
  String language = "km";
  bool production = false;

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

// _showSuccessDialog(){
//   showDialog(
//     context: context,
//     builder: (context){
//       return  AlertDialog(
//         title: const  Text("Payment Success"),
//         content: const  Text("Transaction Already Paid"),
//         actions: [
//           TextButton(
//             onPressed: (){
//                 Navigator.pop(context);
//             },
//             child: const Text("Close")
//             )
//         ],
//       );
//      }
//     );
// }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Merchant App"),
          actions: [
            Container(
                padding: const EdgeInsets.only(right: 15),
                alignment: Alignment.centerRight,
                child: FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      var packageInfo = snapshot.data!;
                      return Text(
                          'V${packageInfo.version}.${packageInfo.buildNumber}');
                    }
                    return const Text('V1.0.0.0');
                  },
                ))
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //transaction no
                  InputTextWidget(
                    label: "transaction no",
                    inputType: TextInputType.text,
                    controller: _transactionNoController,
                    validator: (value) =>
                        _validateInputText(value, "transaction no"),
                    onChanged: (value) {
                      setState(() {
                        _inputText = value;
                      });
                    },
                    pastIcon: IconButton(
                      icon: const Icon(Icons.paste_outlined),
                      onPressed: () async {
                        ClipboardData? clipboard =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        if (clipboard != null) {
                          _transactionNoController.text = clipboard.text ?? "";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //referer key
                  InputTextWidget(
                    label: "referer key",
                    inputType: TextInputType.text,
                    controller: _refererKeyController,
                    validator: (value) =>
                        _validateInputText(value, "referer key"),
                    onChanged: (value) {
                      setState(() {
                        _inputText = value;
                      });
                    },
                    pastIcon: const SizedBox(),
                  ),

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
                              onChanged: (value) {
                                setState(() {
                                  _themeMode = value;
                                  darkMode = false;
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
                              onChanged: (value) {
                                setState(() {
                                  _themeMode = value;
                                  darkMode = true;
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
                              onChanged: (value) {
                                setState(() {
                                  _language = value;
                                  language = "km";
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
                              onChanged: (value) {
                                setState(() {
                                  _language = value;
                                  language = "en";
                                });
                              },
                            ),
                            const Text("English")
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      Checkbox(
                          value: production,
                          onChanged: (value) {
                            setState(() {
                              production = value!;
                            });
                          }),
                      const Text("Production")
                    ],
                  ),

                  //load sdk
                  ButtonWidget(
                      color: Colors.green,
                      name: "Init Sdk",
                      callback: () async {
                        FocusScope.of(context).unfocus();
                        //for call in flutter
                        if (_formKey.currentState!.validate()) {
                          // ignore: use_build_context_synchronously
                          B24PaymentSdk.intSdk(
                              controller: (context),
                              tranId: _transactionNoController.text,
                              refererKey: _refererKeyController.text,
                              darkMode: darkMode,
                              language: language,
                              isProduction: production);
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
