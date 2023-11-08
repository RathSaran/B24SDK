import 'dart:convert';

import 'package:sample_merchant_app_flutter/model/data_verifyv2.dart';

class VerifyTransactionV2Response {
    String code;
    String message;
    String messageKh;
    DataVerifyV2 data;

    VerifyTransactionV2Response({
        required this.code,
        required this.message,
        required this.messageKh,
        required this.data,
    });

    factory VerifyTransactionV2Response.fromRawJson(String str) => VerifyTransactionV2Response.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VerifyTransactionV2Response.fromJson(Map<String, dynamic> json) => VerifyTransactionV2Response(
        code: json["code"],
        message: json["message"],
        messageKh: json["message_kh"],
        data: DataVerifyV2.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "message_kh": messageKh,
        "data": data.toJson(),
    };
}