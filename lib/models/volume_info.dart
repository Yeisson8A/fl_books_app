import 'dart:convert';
import 'models.dart';

class VolumeInfo {
    String? title;
    List<String>? authors;
    String? publisher;
    String? publishedDate;
    String? description;
    ReadingModes readingModes;
    int? pageCount;
    String printType;
    List<String>? categories;
    String maturityRating;
    bool allowAnonLogging;
    String contentVersion;
    PanelizationSummary? panelizationSummary;
    ImageLinks? imageLinks;
    String language;
    String previewLink;
    String infoLink;
    String canonicalVolumeLink;
    List<IndustryIdentifier>? industryIdentifiers;
    String? subtitle;
    double? averageRating;
    int? ratingsCount;
    SeriesInfo? seriesInfo;

    VolumeInfo({
        this.title,
        this.authors,
        this.publisher,
        this.publishedDate,
        this.description,
        required this.readingModes,
        this.pageCount,
        required this.printType,
        this.categories,
        required this.maturityRating,
        required this.allowAnonLogging,
        required this.contentVersion,
        this.panelizationSummary,
        this.imageLinks,
        required this.language,
        required this.previewLink,
        required this.infoLink,
        required this.canonicalVolumeLink,
        this.industryIdentifiers,
        this.subtitle,
        this.averageRating,
        this.ratingsCount,
        this.seriesInfo,
    });

    factory VolumeInfo.fromRawJson(String str) => VolumeInfo.fromJson(json.decode(str));

    factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
        title: json["title"],
        authors: json["authors"] == null ? [] : List<String>.from(json["authors"]!.map((x) => x)),
        publisher: json["publisher"],
        publishedDate: json["publishedDate"],
        description: json["description"],
        readingModes: ReadingModes.fromJson(json["readingModes"]),
        pageCount: json["pageCount"],
        printType: json["printType"],
        categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
        maturityRating: json["maturityRating"],
        allowAnonLogging: json["allowAnonLogging"],
        contentVersion: json["contentVersion"],
        panelizationSummary: json["panelizationSummary"] == null ? null : PanelizationSummary.fromJson(json["panelizationSummary"]),
        imageLinks: json["imageLinks"] == null ? null : ImageLinks.fromJson(json["imageLinks"]),
        language: json["language"],
        previewLink: json["previewLink"],
        infoLink: json["infoLink"],
        canonicalVolumeLink: json["canonicalVolumeLink"],
        industryIdentifiers: json["industryIdentifiers"] == null ? [] : List<IndustryIdentifier>.from(json["industryIdentifiers"]!.map((x) => IndustryIdentifier.fromJson(x))),
        subtitle: json["subtitle"],
        averageRating: json["averageRating"]?.toDouble(),
        ratingsCount: json["ratingsCount"],
        seriesInfo: json["seriesInfo"] == null ? null : SeriesInfo.fromJson(json["seriesInfo"]),
    );
}