import 'dart:convert';

class DataVerifyV2 {
    String tranId;
    DateTime tranDate;
    int tranAmount;
    int feeAmount;
    int totalAmount;
    String currency;
    String identityCode;
    String bankCode;
    String bankRef;
    String purposeOfTransaction;
    String status;
    String description;
    String deviceCode;
    String channelCode;
    List<Customer> customers;

    DataVerifyV2({
        required this.tranId,
        required this.tranDate,
        required this.tranAmount,
        required this.feeAmount,
        required this.totalAmount,
        required this.currency,
        required this.identityCode,
        required this.bankCode,
        required this.bankRef,
        required this.purposeOfTransaction,
        required this.status,
        required this.description,
        required this.deviceCode,
        required this.channelCode,
        required this.customers,
    });

    factory DataVerifyV2.fromRawJson(String str) => DataVerifyV2.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DataVerifyV2.fromJson(Map<String, dynamic> json) => DataVerifyV2(
        tranId: json["tran_id"],
        tranDate: DateTime.parse(json["tran_date"]),
        tranAmount: json["tran_amount"],
        feeAmount: json["fee_amount"],
        totalAmount: json["total_amount"],
        currency: json["currency"],
        identityCode: json["identity_code"],
        bankCode: json["bank_code"],
        bankRef: json["bank_ref"],
        purposeOfTransaction: json["purpose_of_transaction"],
        status: json["status"],
        description: json["description"],
        deviceCode: json["device_code"],
        channelCode: json["channel_code"],
        customers: List<Customer>.from(json["customers"].map((x) => Customer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "tran_id": tranId,
        "tran_date": tranDate.toIso8601String(),
        "tran_amount": tranAmount,
        "fee_amount": feeAmount,
        "total_amount": totalAmount,
        "currency": currency,
        "identity_code": identityCode,
        "bank_code": bankCode,
        "bank_ref": bankRef,
        "purpose_of_transaction": purposeOfTransaction,
        "status": status,
        "description": description,
        "device_code": deviceCode,
        "channel_code": channelCode,
        "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
    };
}

class Customer {
    String branchCode;
    String branchName;
    String customerCode;
    String customerName;
    String customerNameLatin;
    String billNo;
    int amount;

    Customer({
        required this.branchCode,
        required this.branchName,
        required this.customerCode,
        required this.customerName,
        required this.customerNameLatin,
        required this.billNo,
        required this.amount,
    });

    factory Customer.fromRawJson(String str) => Customer.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        branchCode: json["branch_code"],
        branchName: json["branch_name"],
        customerCode: json["customer_code"],
        customerName: json["customer_name"],
        customerNameLatin: json["customer_name_latin"],
        billNo: json["bill_no"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "branch_code": branchCode,
        "branch_name": branchName,
        "customer_code": customerCode,
        "customer_name": customerName,
        "customer_name_latin": customerNameLatin,
        "bill_no": billNo,
        "amount": amount,
    };
}