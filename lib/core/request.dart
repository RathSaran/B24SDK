// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:sample_merchant_app_flutter/core/base_url.dart';
import 'package:sample_merchant_app_flutter/model/customer.dart';
import 'package:sample_merchant_app_flutter/model/transaction_response.dart';
import 'package:sample_merchant_app_flutter/model/transactionv2.dart';
import 'package:http/http.dart' as http;

class RequestAPI {
  Future<void> authorizeToken() async {}

  static Future<TransactionResponse?> initTranV2Async(TransactionV2 transaction,Customer customer) async {

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'token': '1f78ef77601c4ca7a66f7392ac4f9d1d' //5537
    };

    final Map<String, dynamic> body = {
      "identity_code": transaction.identityCode,
      "purpose_of_transaction": transaction.identityCode,
      "device_code": transaction.deviceCode,
      "description": transaction.description,
      "currency": transaction.currency,
      "amount": transaction.amount,
      "language": transaction.language,
      "cancel_url": transaction.cancelUrl,
      "redirect_url": transaction.redirectUrl,
      "channel_code": transaction.channelCode,
      "user_ref": transaction.userRef,
      "customers": [
        {
          "branch_code": customer.branchCode,
          "branch_name": customer.branchName,
          "customer_code": customer.customerCode,
          "customer_name": customer.customerName,
          "customer_name_latin": customer.customerNameLatin,
          "bill_no": customer.billNo,
          "amount": customer.amount
        }
      ]
    };

    try {
      // final response =
      //     await http.post(
      //       Uri.parse(BaseRequestURL.initTranV2), headers: headers, body: json.encode(body));


    // response.body;

    // print(response.body);


    // return TransactionResponse.fromJson(json.decode(response.body));

  
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }


  static Future<String> checkoutDetailAsyc(String refererKey,String tranNo) async{
       final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': '529404f1-e439-45ba-b3f2-cdd7dc3cc336' ,//5537
        'X-Referrer-Key':refererKey
        };

        final Map<String, dynamic> body = {
          "tran_id": tranNo,
        };

        try{
          final response=await http.post(
                     Uri.parse(BaseRequestURL.checkoutDetail),
                     headers: headers,
                     body: json.encode(body)
            );

            final data=jsonDecode(response.body);

            // print(data['data']['trans_info']['status']);

            return data['data']['trans_info']['status'];

        }catch(ex){
            throw Exception(ex);
        }
  }
}
