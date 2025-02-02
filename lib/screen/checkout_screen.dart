import 'dart:convert';

import 'package:b24_payment_sdk/b24_payment_sdk.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sample_merchant_app_flutter/const/constant.dart';
import 'package:sample_merchant_app_flutter/helper/SharePreferenceManager.dart';
import 'package:sample_merchant_app_flutter/helper/generate_text.dart';
import 'package:sample_merchant_app_flutter/model/product_item.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  SharePreferenceManager sharePreferenceManager;
  CheckoutScreen({super.key, required this.sharePreferenceManager});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<ProductItem> productList = [
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-01.jpg",
        amount: 2.0,
        currency: "USD"),
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-02.jpg",
        amount: 5.0,
        currency: "USD"),
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-03.jpg",
        amount: 10.0,
        currency: "USD"),
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-04.jpg",
        amount: 20.0,
        currency: "USD"),
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-05.jpg",
        amount: 50.0,
        currency: "USD"),
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-06.jpg",
        amount: 100.0,
        currency: "USD"),
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-01.jpg",
        amount: 1000.0,
        currency: "KHR"),
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-02.jpg",
        amount: 5000.0,
        currency: "KHR"),
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-03.jpg",
        amount: 10000.0,
        currency: "KHR"),
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-04.jpg",
        amount: 20000.0,
        currency: "KHR"),
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-05.jpg",
        amount: 50000.0,
        currency: "KHR"),
    ProductItem(
        imageUrl:
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-06.jpg",
        amount: 700.0,
        currency: "KHR")
  ];

  _buildCard(String imageUrl, double amount, String currency) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
            width: 70,
            height: 70,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const SizedBox(
                  height: 15, width: 15, child: CircularProgressIndicator()),
            )),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Amount :"),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${amount.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(currency,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16))
            ],
          ),
        ),
      ]),
    );
  }

  _initTransaction(BuildContext context, double amount, String currency) async {
    final url = Uri.parse(Constant.initTransactionUrl);
    final headers = {
      "Content-Type": "application/json",
      "token":
          widget.sharePreferenceManager.prefs.getString(Constant.tokenKey) ??
              "1f78ef77601c4ca7a66f7392ac4f9d1d"
    };
    final body = jsonEncode({
      "identity_code": Generate.generateText(),
      "purpose_of_transaction": "",
      "device_code": "111",
      "description": "",
      "currency": currency,
      "amount": amount,
      "language": "",
      "cancel_url": "",
      "redirect_url":
          widget.sharePreferenceManager.prefs.getString(Constant.redirect),
      "channel_code": "CH1",
      "user_ref": "abc",
      "customers": [
        {
          "branch_code": "01",
          "branch_name": "BBB",
          "customer_code": "C01",
          "customer_name": "BOT",
          "customer_name_latin": "BOT",
          "bill_no": "123",
          "amount": amount
        }
      ]
    });

    //request
    try {
      final response = await http.post(url, headers: headers, body: body);
      debugPrint("=======>success");
      if (response.statusCode == 200) {
        final responseDecode = jsonDecode(response.body);
        if (responseDecode['code'] == 'SUCCESS') {
          // B24PaymentSdk.intSdk(
          //     // ignore: use_build_context_synchronously
          //     controller: (context),
          //     tranId: responseDecode['data']['tran_id'],
          //     refererKey: widget.sharePreferenceManager.prefs
          //         .getString(Constant.refererKey)!,
          //     language: widget.sharePreferenceManager.prefs
          //         .getString(Constant.languageKey),
          //     darkMode: widget.sharePreferenceManager.prefs
          //                 .getString(Constant.themeKey) ==
          //             "false"
          //         ? false
          //         : true);
        } else {
          // ignore: use_build_context_synchronously
          showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(responseDecode['code']),
                  content: Text(responseDecode['message']),
                );
              });
        }
      } else {
        showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Error"),
                content: Text("Internal Server Error"),
              );
            });
      }
    } catch (ex) {
      debugPrint("=======>${ex.toString()}");
    }

    //if (response.statusCode == 200) {}
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Checkout"),
        ),
        body: Stack(
          children: [
            GridView.builder(
              itemCount: productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    await _initTransaction(
                      context,
                      productList[index].amount,
                      productList[index].currency,
                    );

                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: _buildCard(
                    productList[index].imageUrl,
                    productList[index].amount,
                    productList[index].currency,
                  ),
                );
              },
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              ),
          ],
        ));
  }
}
