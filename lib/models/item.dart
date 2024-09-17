import 'dart:convert';
import 'models.dart';

class Item {
    String kind;
    String id;
    String etag;
    String selfLink;
    VolumeInfo volumeInfo;
    SaleInfo saleInfo;
    AccessInfo accessInfo;
    SearchInfo? searchInfo;

    Item({
        required this.kind,
        required this.id,
        required this.etag,
        required this.selfLink,
        required this.volumeInfo,
        required this.saleInfo,
        required this.accessInfo,
        this.searchInfo,
    });

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        kind: json["kind"],
        id: json["id"],
        etag: json["etag"],
        selfLink: json["selfLink"],
        volumeInfo: VolumeInfo.fromJson(json["volumeInfo"]),
        saleInfo: SaleInfo.fromJson(json["saleInfo"]),
        accessInfo: AccessInfo.fromJson(json["accessInfo"]),
        searchInfo: json["searchInfo"] == null ? null : SearchInfo.fromJson(json["searchInfo"]),
    );
}