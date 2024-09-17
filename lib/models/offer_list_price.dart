import 'dart:convert';

class OfferListPrice {
    int amountInMicros;
    String currencyCode;

    OfferListPrice({
        required this.amountInMicros,
        required this.currencyCode,
    });

    factory OfferListPrice.fromRawJson(String str) => OfferListPrice.fromJson(json.decode(str));

    factory OfferListPrice.fromJson(Map<String, dynamic> json) => OfferListPrice(
        amountInMicros: json["amountInMicros"],
        currencyCode: json["currencyCode"],
    );
}