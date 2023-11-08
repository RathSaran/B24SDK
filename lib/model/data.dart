import 'dart:convert';

class Data {
    String identityCode;
    String paymentLink;
    String khqrString;
    String tranId;

    Data({
        required this.identityCode,
        required this.paymentLink,
        required this.khqrString,
        required this.tranId,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        identityCode: json["identity_code"],
        paymentLink: json["payment_link"],
        khqrString: json["khqr_string"],
        tranId: json["tran_id"],
    );

    Map<String, dynamic> toJson() => {
        "identity_code": identityCode,
        "payment_link": paymentLink,
        "khqr_string": khqrString,
        "tran_id": tranId,
    };
}