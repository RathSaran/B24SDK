import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sample_merchant_app_flutter/helper/SharePreferenceManager.dart';
import 'package:sample_merchant_app_flutter/screen/checkout_screen.dart';
import 'package:sample_merchant_app_flutter/screen/setting_screen.dart';
import 'package:sample_merchant_app_flutter/widget/button_widget.dart';
import 'package:sample_merchant_app_flutter/widget/input_text_widget.dart';
import 'package:b24_payment_sdk/b24_payment_sdk.dart';

enum ThemeMode { darkMode, lightMode }

enum Language { km, en }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharePreferenceManager sharePreferenceManager = SharePreferenceManager();

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

  _initSharePref() async {
    await sharePreferenceManager.init();
  }

  _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                    sharePreferenceManager:
                                        sharePreferenceManager,
                                  )));
                    },
                    child: const Text("Checkout"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen(
                                    sharePreferenceManager:
                                        sharePreferenceManager,
                                  )));
                    },
                    child: const Text("Setting"),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // _initInputValue() {
  //   sharePreferenceManager.prefs
  //       .setString(Constant.tokenKey, "1f78ef77601c4ca7a66f7392ac4f9d1d");

  //   sharePreferenceManager.prefs.setString(Constant.refererKey, "123X");

  //   sharePreferenceManager.prefs.setString(Constant.redirect, "http://dl-merchant-sample.bill24.io/success");

  // sharePreferenceManager.prefs
  //                   .setString(Constant.languageKey, "km");

  // sharePreferenceManager.prefs
  //                   .setString(Constant.themeKey, "false");
  // }

  @override
  Widget build(BuildContext context) {
    _initSharePref();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("DeepLink "),
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
                      return const Text('V1.2.0-beta.1');
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
                            _transactionNoController.text =
                                clipboard.text ?? "";
                          }

                          //Restart.restartApp();
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
                            //ignore: use_build_context_synchronously
                            B24PaymentSdk.initSdk(
                                controller: (context),
                                tranId: _transactionNoController.text,
                                refererKey: _refererKeyController.text,
                                darkMode: darkMode,
                                language: language,
                                isProduction: production,
                                testingEnv: "STAG");
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.settings),
              onPressed: () {
                _showBottomSheet();
              })),
    );
  }
}
