import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_merchant_app_flutter/const/constant.dart';
import 'package:sample_merchant_app_flutter/helper/SharePreferenceManager.dart';
import 'package:sample_merchant_app_flutter/widget/button_widget.dart';
import 'package:sample_merchant_app_flutter/widget/input_text_widget.dart';

class SettingScreen extends StatefulWidget {
  final SharePreferenceManager sharePreferenceManager;

  const SettingScreen({super.key, required this.sharePreferenceManager});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _tokenController = TextEditingController();
  final _refererKeyController = TextEditingController();
  final _redirectController = TextEditingController();
  final _languageController = TextEditingController();
  final _themeController = TextEditingController();

  String? _validateInputText(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'Please input $field';
    }
  }

  _initInputValue() {
    _tokenController.text = widget.sharePreferenceManager.prefs
                    .getString(Constant.tokenKey) ==
                "" ||
            widget.sharePreferenceManager.prefs.getString(Constant.tokenKey) ==
                null
        ? "1f78ef77601c4ca7a66f7392ac4f9d1d"
        : widget.sharePreferenceManager.prefs.getString(Constant.tokenKey)!;

    _refererKeyController.text = widget.sharePreferenceManager.prefs
                    .getString(Constant.refererKey) ==
                "" ||
            widget.sharePreferenceManager.prefs
                    .getString(Constant.refererKey) ==
                null
        ? "123X"
        : widget.sharePreferenceManager.prefs.getString(Constant.refererKey)!;

    _redirectController.text = widget.sharePreferenceManager.prefs
                    .getString(Constant.redirect) ==
                "" ||
            widget.sharePreferenceManager.prefs.getString(Constant.redirect) ==
                null
        ? "http://dl-merchant-sample.bill24.io/success"
        : widget.sharePreferenceManager.prefs.getString(Constant.redirect)!;

    _languageController.text = widget.sharePreferenceManager.prefs
                    .getString(Constant.languageKey) ==
                "" ||
            widget.sharePreferenceManager.prefs
                    .getString(Constant.languageKey) ==
                null
        ? "km"
        : widget.sharePreferenceManager.prefs.getString(Constant.languageKey)!;

    _themeController.text = widget.sharePreferenceManager.prefs
                    .getString(Constant.themeKey) ==
                "" ||
            widget.sharePreferenceManager.prefs.getString(Constant.themeKey) ==
                null
        ? "false"
        : widget.sharePreferenceManager.prefs.getString(Constant.themeKey)!;
  }

  _savePreferences() {
    widget.sharePreferenceManager.prefs
        .setString(Constant.tokenKey, _tokenController.text);
    widget.sharePreferenceManager.prefs
        .setString(Constant.refererKey, _refererKeyController.text);
    widget.sharePreferenceManager.prefs
        .setString(Constant.redirect, _redirectController.text);
    widget.sharePreferenceManager.prefs
        .setString(Constant.languageKey, _languageController.text);
    widget.sharePreferenceManager.prefs
        .setString(Constant.themeKey, _themeController.text);
  }

  @override
  void initState() {
    _initInputValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              InputTextWidget(
                  label: "token",
                  inputType: TextInputType.text,
                  controller: _tokenController,
                  validator: (value) {},
                  onChanged: (newValue) {},
                  pastIcon: InkWell(
                      onTap: () async {
                        ClipboardData? clipboard =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        if (clipboard != null) {
                          _tokenController.text = clipboard.text ?? "";
                        }
                      },
                      child: const Icon(Icons.paste))),
              const SizedBox(
                height: 10,
              ),
              InputTextWidget(
                  label: "refererKey",
                  inputType: TextInputType.text,
                  controller: _refererKeyController,
                  validator: (value) {},
                  onChanged: (newValue) {},
                  pastIcon: InkWell(
                      onTap: () async {
                        ClipboardData? clipboard =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        if (clipboard != null) {
                          _refererKeyController.text = clipboard.text ?? "";
                        }
                      },
                      child: const Icon(Icons.paste))),
              const SizedBox(
                height: 10,
              ),
              InputTextWidget(
                  label: "redirect url",
                  inputType: TextInputType.text,
                  controller: _redirectController,
                  validator: (value) {},
                  onChanged: (newValue) {},
                  pastIcon: InkWell(
                      onTap: () async {
                        ClipboardData? clipboard =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        if (clipboard != null) {
                          _redirectController.text = clipboard.text ?? "";
                        }
                      },
                      child: const Icon(Icons.paste))),
              const SizedBox(
                height: 10,
              ),
              InputTextWidget(
                  label: "language",
                  inputType: TextInputType.text,
                  controller: _languageController,
                  validator: (value) {},
                  onChanged: (newValue) {},
                  pastIcon: InkWell(
                      onTap: () async {
                        ClipboardData? clipboard =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        if (clipboard != null) {
                          _languageController.text = clipboard.text ?? "";
                        }
                      },
                      child: const Icon(Icons.paste))),
              const SizedBox(
                height: 10,
              ),
              InputTextWidget(
                  label: "theme",
                  inputType: TextInputType.text,
                  controller: _themeController,
                  validator: (value) {},
                  onChanged: (newValue) {},
                  pastIcon: InkWell(
                      onTap: () async {
                        ClipboardData? clipboard =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        if (clipboard != null) {
                          _themeController.text = clipboard.text ?? "";
                        }
                      },
                      child: const Icon(Icons.paste))),
              const SizedBox(
                height: 10,
              ),
              ButtonWidget(
                  color: Colors.blueAccent,
                  name: "Save",
                  callback: () {
                    _savePreferences();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Setting Saved!")));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
