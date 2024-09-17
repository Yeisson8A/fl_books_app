import 'dart:convert';
import 'models.dart';

class SaleInfo {
    String country;
    String saleability;
    bool isEbook;
    SaleInfoListPrice? listPrice;
    SaleInfoListPrice? retailPrice;
    String? buyLink;
    List<Offer>? offers;

    SaleInfo({
        required this.country,
        required this.saleability,
        required this.isEbook,
        this.listPrice,
        this.retailPrice,
        this.buyLink,
        this.offers,
    });

    factory SaleInfo.fromRawJson(String str) => SaleInfo.fromJson(json.decode(str));

    factory SaleInfo.fromJson(Map<String, dynamic> json) => SaleInfo(
        country: json["country"],
        saleability: json["saleability"],
        isEbook: json["isEbook"],
        listPrice: json["listPrice"] == null ? null : SaleInfoListPrice.fromJson(json["listPrice"]),
        retailPrice: json["retailPrice"] == null ? null : SaleInfoListPrice.fromJson(json["retailPrice"]),
        buyLink: json["buyLink"],
        offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
    );
}