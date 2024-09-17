import 'dart:convert';

class Epub {
    bool isAvailable;
    String? acsTokenLink;
    String? downloadLink;

    Epub({
        required this.isAvailable,
        this.acsTokenLink,
        this.downloadLink,
    });

    factory Epub.fromRawJson(String str) => Epub.fromJson(json.decode(str));

    factory Epub.fromJson(Map<String, dynamic> json) => Epub(
        isAvailable: json["isAvailable"],
        acsTokenLink: json["acsTokenLink"],
        downloadLink: json["downloadLink"],
    );
}