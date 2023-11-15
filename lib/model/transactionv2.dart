import 'dart:convert';
import 'package:sample_merchant_app_flutter/model/customer.dart';

class TransactionV2 {
    String identityCode;
    String purposeOfTransaction;
    String deviceCode;
    String description;
    String currency;
    double amount;
    String language;
    String cancelUrl;
    String redirectUrl;
    String channelCode;
    String userRef;
    List<Customer> customers;

    TransactionV2({
        required this.identityCode,
        required this.purposeOfTransaction,
        required this.deviceCode,
        required this.description,
        required this.currency,
        required this.amount,
        required this.language,
        required this.cancelUrl,
        required this.redirectUrl,
        required this.channelCode,
        required this.userRef,
        required this.customers,
    });

    factory TransactionV2.fromRawJson(String str) => TransactionV2.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TransactionV2.fromJson(Map<String, dynamic> json) => TransactionV2(
        identityCode: json["identity_code"],
        purposeOfTransaction: json["purpose_of_transaction"],
        deviceCode: json["device_code"],
        description: json["description"],
        currency: json["currency"],
        amount: json["amount"].toDouble(),
        language: json["language"],
        cancelUrl: json["cancel_url"],
        redirectUrl: json["redirect_url"],
        channelCode: json["channel_code"],
        userRef: json["user_ref"],
        customers: List<Customer>.from(json["customers"].map((x) => Customer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "identity_code": identityCode,
        "purpose_of_transaction": purposeOfTransaction,
        "device_code": deviceCode,
        "description": description,
        "currency": currency,
        "amount": amount,
        "language": language,
        "cancel_url": cancelUrl,
        "redirect_url": redirectUrl,
        "channel_code": channelCode,
        "user_ref": userRef,
        "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
    };
}