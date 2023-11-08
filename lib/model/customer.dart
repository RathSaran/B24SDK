import 'dart:convert';

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