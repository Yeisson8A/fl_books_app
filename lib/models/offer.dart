import 'dart:convert';
import 'models.dart';

class Offer {
    int finskyOfferType;
    OfferListPrice listPrice;
    OfferListPrice retailPrice;

    Offer({
        required this.finskyOfferType,
        required this.listPrice,
        required this.retailPrice,
    });

    factory Offer.fromRawJson(String str) => Offer.fromJson(json.decode(str));

    factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        finskyOfferType: json["finskyOfferType"],
        listPrice: OfferListPrice.fromJson(json["listPrice"]),
        retailPrice: OfferListPrice.fromJson(json["retailPrice"]),
    );
}