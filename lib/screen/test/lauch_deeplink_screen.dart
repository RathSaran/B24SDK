import 'package:b24_direct_debit_sdk/presentation/widgets/sizebox_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_merchant_app_flutter/helper/helper.dart';
import 'package:sample_merchant_app_flutter/widget/button_widget.dart';
import 'package:sample_merchant_app_flutter/widget/input_widget.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

class LauchDeeplinkScreen extends StatelessWidget {
  LauchDeeplinkScreen({super.key});

  final _redirectUrlController = TextEditingController();
  String url = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            InputWidget(
                label: Text('redirect url'),
                controller: _redirectUrlController,
                suffixIcon: IconButton(
                    onPressed: () {
                      pasteText(_redirectUrlController);
                    },
                    icon: Icon(Icons.paste)),
                onChanged: (value) {}),
            SizeboxCustom(
              height: 20,
            ),
            ButtonWidget(
                color: Colors.blueAccent,
                name: 'Url Launcher',
                callback: () async {
                  if (_redirectUrlController.text.isEmpty) {
                    url = 'https://dl-merchant-sample.bill24.io/subscription';
                  } else {
                    url = _redirectUrlController.text;
                  }
                  if (await canLaunchUrl(Uri.parse(url))) {
                    if (UniversalPlatform.isAndroid) {
                      var dd = await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                      debugPrint('$dd');
                    } else {
                      var dd = await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                      debugPrint('$dd');
                    }
                  }
                }),
            SizeboxCustom(
              height: 20,
            ),
            ButtonWidget(
                color: Colors.blueAccent,
                name: 'Go Route',
                callback: () async {
                  if (_redirectUrlController.text.isEmpty) {
                   // url = 'https://dl-merchant-sample.bill24.io/subscription';
                    url = "https://www.google.com/";
                  } else {
                    url = _redirectUrlController.text;
                  }

                  final goRouter = GoRouter.of(context);
                  if (goRouter.canPop()) {
                    goRouter.go(url);
                    debugPrint("go route ");
                  } else {
                    debugPrint("other ");
                  }
                  // try {
                  //   GoRouter.of(context).go(url);
                  //   debugPrint('go route $url');
                  // } catch (ex) {
                  //   debugPrint(ex.toString());
                  //   if (await canLaunchUrl(Uri.parse(url))) {
                  //     var dd = await launchUrl(Uri.parse(url));
                  //     debugPrint('$dd');
                  //   }
                  // }
                })
          ],
        ),
      ),
    );
  }
}
