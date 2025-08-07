import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sample_merchant_app_flutter/helper/SharePreferenceManager.dart';
import 'package:sample_merchant_app_flutter/screen/checkout_screen.dart';
import 'package:sample_merchant_app_flutter/screen/home_screen.dart';
import 'package:sample_merchant_app_flutter/screen/setting_screen.dart';
import 'package:sample_merchant_app_flutter/widget/button_widget.dart';
import 'package:sample_merchant_app_flutter/widget/input_text_widget.dart';
import 'package:b24_payment_sdk/b24_payment_sdk.dart';
import 'package:go_router/go_router.dart';

enum ThemeMode { darkMode, lightMode }

enum Language { km, en }

class HomeScreenWallet extends StatefulWidget {
  const HomeScreenWallet({Key? key}) : super(key: key);

  @override
  State<HomeScreenWallet> createState() => _HomeScreenWalletState();
}

class _HomeScreenWalletState extends State<HomeScreenWallet> {
  SharePreferenceManager sharePreferenceManager = SharePreferenceManager();

  final _transactionNoController = TextEditingController();
  final _refererKeyController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _inputText = '';

  String? _validateInputText(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'Please input $field';
    }
    return null;
  }

  ThemeMode? _themeMode = ThemeMode.lightMode;
  Language? _language = Language.km;
  bool darkMode = false;
  String language = "km";
  bool isProduction = false;
  String environment = "STAG";

  _initSharePref() async {
    await sharePreferenceManager.init();
    setState(() {
      environment =
          sharePreferenceManager.prefs.getString('environment') ?? "STAG";
      isProduction =
          sharePreferenceManager.prefs.getBool('isProduction') ?? false;
    });
  }

  _saveEnvironment(String env) async {
    await sharePreferenceManager.prefs.setString('environment', env);
  }

  _saveProduction(bool prod) async {
    await sharePreferenceManager.prefs.setBool('isProduction', prod);
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

  @override
  Widget build(BuildContext context) {
    _initSharePref();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Digital Wallet"),
            leading: PopupMenuButton<String>(
              onSelected: (value) {
                context.go(value); // Use GoRouter to navigate
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: '/page1',
                  child: Text('Wallet'),
                ),
                const PopupMenuItem(
                  value: '/page2',
                  child: Text('Deeplink'),
                ),
                const PopupMenuItem(
                  value: '/page3',
                  child: Text('DirectDebit'),
                ),
              ],
              icon: const Icon(Icons.menu),
            ),
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => HomeScreen()));
            //   },
            //   icon: Icon(Icons.swipe),
            // ),
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
                      label: "customerSynCode",
                      inputType: TextInputType.text,
                      controller: _transactionNoController,
                      validator: (value) =>
                          _validateInputText(value, "customerSynCode"),
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
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    //production checkbox
                    Row(
                      children: [
                        Checkbox(
                            value: isProduction,
                            onChanged: (value) {
                              setState(() {
                                isProduction = value!;
                                _saveProduction(value);
                              });
                            }),
                        const Text("Production")
                      ],
                    ),
                    //environment dropdown
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Environment: "),
                          DropdownButton<String>(
                            value: environment,
                            items: const [
                              DropdownMenuItem(
                                value: "DEMO",
                                child: Text("Demo"),
                              ),
                              DropdownMenuItem(
                                value: "STAG",
                                child: Text("Stage"),
                              ),
                              DropdownMenuItem(
                                value: "PRODUCTION",
                                child: Text("Production"),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  environment = value;
                                  _saveEnvironment(value);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    //load sdk
                    ButtonWidget(
                        color: Colors.green,
                        name: "Init Sdk",
                        callback: () async {
                          print("------->$isProduction");
                          print("===============>$environment");
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            B24PaymentSdk.initInstantPaymentSdk(
                                context: context,
                                customerSyncCode: _transactionNoController.text,
                                refererKey: _refererKeyController.text,
                                isDarkmode: darkMode,
                                isProduction: isProduction,
                                language: language,
                                testingEnv: environment);
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
