import 'dart:convert';

class VerifyTransactionV2 {
    String identityCode;
    String tranId;
    String bankRef;
    String purposeOfTransaction;

    VerifyTransactionV2({
        required this.identityCode,
        required this.tranId,
        required this.bankRef,
        required this.purposeOfTransaction,
    });

    factory VerifyTransactionV2.fromRawJson(String str) => VerifyTransactionV2.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VerifyTransactionV2.fromJson(Map<String, dynamic> json) => VerifyTransactionV2(
        identityCode: json["identity_code"],
        tranId: json["tran_id"],
        bankRef: json["bank_ref"],
        purposeOfTransaction: json["purpose_of_transaction"],
    );

    Map<String, dynamic> toJson() => {
        "identity_code": identityCode,
        "tran_id": tranId,
        "bank_ref": bankRef,
        "purpose_of_transaction": purposeOfTransaction,
    };
}