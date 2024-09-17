import 'dart:convert';
import 'models.dart';

class BooksResponse {
    String kind;
    int totalItems;
    List<Item> items;

    BooksResponse({
        required this.kind,
        required this.totalItems,
        required this.items,
    });

    factory BooksResponse.fromRawJson(String str) => BooksResponse.fromJson(json.decode(str));

    factory BooksResponse.fromJson(Map<String, dynamic> json) => BooksResponse(
        kind: json["kind"],
        totalItems: json["totalItems"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );
}