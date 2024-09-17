import 'dart:convert';

class ImageLinks {
    String smallThumbnail;
    String thumbnail;

    ImageLinks({
        required this.smallThumbnail,
        required this.thumbnail,
    });

    factory ImageLinks.fromRawJson(String str) => ImageLinks.fromJson(json.decode(str));

    factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail: json["smallThumbnail"],
        thumbnail: json["thumbnail"],
    );
}