import 'dart:convert';

class SaleInfoListPrice {
    int amount;
    String currencyCode;

    SaleInfoListPrice({
        required this.amount,
        required this.currencyCode,
    });

    factory SaleInfoListPrice.fromRawJson(String str) => SaleInfoListPrice.fromJson(json.decode(str));

    factory SaleInfoListPrice.fromJson(Map<String, dynamic> json) => SaleInfoListPrice(
        amount: json["amount"],
        currencyCode: json["currencyCode"],
    );
}