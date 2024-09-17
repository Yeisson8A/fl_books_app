import 'dart:convert';

class ReadingModes {
    bool text;
    bool image;

    ReadingModes({
        required this.text,
        required this.image,
    });

    factory ReadingModes.fromRawJson(String str) => ReadingModes.fromJson(json.decode(str));

    factory ReadingModes.fromJson(Map<String, dynamic> json) => ReadingModes(
        text: json["text"],
        image: json["image"],
    );
}