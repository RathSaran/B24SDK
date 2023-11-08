import 'dart:convert';
import 'package:sample_merchant_app_flutter/model/data.dart';

class TransactionResponse {
    String code;
    String message;
    String messageKh;
    Data data;

    TransactionResponse({
        required this.code,
        required this.message,
        required this.messageKh,
        required this.data,
    });

    factory TransactionResponse.fromRawJson(String str) => TransactionResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TransactionResponse.fromJson(Map<String, dynamic> json) => TransactionResponse(
        code: json["code"],
        message: json["message"],
        messageKh: json["message_kh"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "message_kh": messageKh,
        "data": data.toJson(),
    };
}