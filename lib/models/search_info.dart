import 'dart:convert';

class SearchInfo {
    String textSnippet;

    SearchInfo({
        required this.textSnippet,
    });

    factory SearchInfo.fromRawJson(String str) => SearchInfo.fromJson(json.decode(str));

    factory SearchInfo.fromJson(Map<String, dynamic> json) => SearchInfo(
        textSnippet: json["textSnippet"],
    );
}