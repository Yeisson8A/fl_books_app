import 'dart:convert';

class IndustryIdentifier {
    String type;
    String identifier;

    IndustryIdentifier({
        required this.type,
        required this.identifier,
    });

    factory IndustryIdentifier.fromRawJson(String str) => IndustryIdentifier.fromJson(json.decode(str));

    factory IndustryIdentifier.fromJson(Map<String, dynamic> json) => IndustryIdentifier(
        type: json["type"],
        identifier: json["identifier"],
    );
}