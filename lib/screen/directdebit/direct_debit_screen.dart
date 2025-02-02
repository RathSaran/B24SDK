import 'package:b24_direct_debit_sdk/b24_direct_debit_sdk.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sample_merchant_app_flutter/helper/helper.dart';
import 'package:sample_merchant_app_flutter/provider/merchant_provider.dart';
import 'package:sample_merchant_app_flutter/screen/home_screen.dart';
import 'package:sample_merchant_app_flutter/screen/test/lauch_deeplink_screen.dart';
import 'package:sample_merchant_app_flutter/widget/button_widget_cus.dart';
import 'package:sample_merchant_app_flutter/widget/input_widget.dart';
import 'package:sample_merchant_app_flutter/widget/sizebox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class InitDirectDebitScreen extends StatefulWidget {
  String env = 'Demo';
  bool envBool = true;
  InitDirectDebitScreen({super.key});

  @override
  State<InitDirectDebitScreen> createState() => _InitDirectDebitScreenState();
}

class _InitDirectDebitScreenState extends State<InitDirectDebitScreen> {
  final _subscriptonNoController = TextEditingController();
  final _refererKeyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.blue,
          title: const Text(
            "Merchant DD",
            style: TextStyle(color: Colors.white),
          ),
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
                        'V${packageInfo.version}.${packageInfo.buildNumber}',
                        style: const TextStyle(color: Colors.white),
                      );
                    }
                    return const Text('V1.0.0.0');
                  },
                ))
          ],
        ),
        drawer: _buildNavigationDrawer(context),
        body: ChangeNotifierProvider(
          create: (_) => MerchantProvider(),
          child:
              Consumer<MerchantProvider>(builder: (context, provider, child) {
            getSharePref(provider);
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizeboxWidget(
                      height: 40,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InputWidget(
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please input Subscription No';
                                }
                                // return null if the validation passes
                              },
                              onChanged: (value) {
                                setState(() {
                                  _subscriptonNoController.text = value;
                                });
                              },
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    pasteText(_subscriptonNoController);
                                  },
                                  icon: const Icon(Icons.paste_outlined)),
                              label: const Text('Subscription No'),
                              controller: _subscriptonNoController),
                          const SizeboxWidget(),
                          InputWidget(
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please input Referer Key';
                                }
                              },
                              onChanged: (value) {
                                _refererKeyController.text = value;
                              },
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    pasteText(_refererKeyController);
                                  },
                                  icon: const Icon(Icons.paste_outlined)),
                              label: const Text('Referer Key'),
                              controller: _refererKeyController),
                          Row(
                            children: [
                              Checkbox(
                                  value: provider.isDarkMode,
                                  onChanged: (value) {
                                    provider.setDarkMode(value!);
                                  }),
                              const Text('DarkMode'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: provider.isProduction,
                                  onChanged: (value) {
                                    provider.setProduction(value!);
                                  }),
                              const Text('Production'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: provider.isEnglish,
                                  onChanged: (value) {
                                    provider.setEnglish(value!);
                                  }),
                              const Text('English'),
                            ],
                          ),
                          const SizeboxWidget(
                            height: 20,
                          ),
                          const Text("Testing Environment"),
                          Row(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                      value: 'Demo',
                                      groupValue: provider.selectOption,
                                      onChanged: (value) {
                                        provider.changeEnvironment(value!);
                                        setSharePref(env: value);
                                      }),
                                  const Text('Demo')
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                      value: 'Stag',
                                      groupValue: provider.selectOption,
                                      onChanged: (value) {
                                        provider.changeEnvironment(value!);
                                        setSharePref(env: value);
                                      }),
                                  const Text("Staging")
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                      value: 'Pilot',
                                      groupValue: provider.selectOption,
                                      onChanged: (value) {
                                        provider.changeEnvironment(value!);
                                        setSharePref(env: value);
                                      }),
                                  const Text("Pilot")
                                ],
                              ),
                            ],
                          ),
                          ButtonWidget(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  B24DirectDebitSdk.initSdk(
                                      context: context,
                                      subscriptionNo:
                                          _subscriptonNoController.text,
                                      refererKey: _refererKeyController.text,
                                      isDarkMode: provider.isDarkMode,
                                      language:
                                          provider.isEnglish ? 'en' : 'km',
                                      isProduction: provider.isProduction,
                                      testingEnv:
                                          provider.selectOption ?? 'Dev');
                                }
                              },
                              text: 'Init SDK')
                        ],
                      ),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  
  }
}

setSharePref({String env = 'Demo'}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('ENV', env);
}

getSharePref(MerchantProvider provider) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  provider.selectOption = await pref.getString('ENV');
  provider.notify();
}

_buildNavigationDrawer(BuildContext context) {
  return Drawer(
    surfaceTintColor: Colors.white,
    child: SafeArea(
        child: Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              const DrawerHeader(child: Text("MERCHANT PLATFORM")),
              ListTile(
                leading: const Icon(Icons.add_box_outlined),
                title: const Text("INIT DEEPLINk"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
              ),
               ListTile(
                leading: const Icon(Icons.add_box_outlined),
                title: const Text("TEST REDIRECT"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LauchDeeplinkScreen()));
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.settings_outlined),
              //   title: const Text("Setting Config"),
              //   onTap: () {
              //     // Navigator.of(context).pop();
              //     // Navigator.of(context).push(
              //     //     MaterialPageRoute(builder: (context) => SettingConfig()));
              //   },
              // )
            ],
          ),
        )
      ],
    )),
  );
}
