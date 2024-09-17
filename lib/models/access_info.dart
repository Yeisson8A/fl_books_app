import 'dart:convert';
import 'models.dart';

class AccessInfo {
    String country;
    String viewability;
    bool embeddable;
    bool publicDomain;
    String textToSpeechPermission;
    Epub epub;
    Epub pdf;
    String webReaderLink;
    String accessViewStatus;
    bool quoteSharingAllowed;

    AccessInfo({
        required this.country,
        required this.viewability,
        required this.embeddable,
        required this.publicDomain,
        required this.textToSpeechPermission,
        required this.epub,
        required this.pdf,
        required this.webReaderLink,
        required this.accessViewStatus,
        required this.quoteSharingAllowed,
    });

    factory AccessInfo.fromRawJson(String str) => AccessInfo.fromJson(json.decode(str));

    factory AccessInfo.fromJson(Map<String, dynamic> json) => AccessInfo(
        country: json["country"],
        viewability: json["viewability"],
        embeddable: json["embeddable"],
        publicDomain: json["publicDomain"],
        textToSpeechPermission: json["textToSpeechPermission"],
        epub: Epub.fromJson(json["epub"]),
        pdf: Epub.fromJson(json["pdf"]),
        webReaderLink: json["webReaderLink"],
        accessViewStatus: json["accessViewStatus"],
        quoteSharingAllowed: json["quoteSharingAllowed"],
    );
}