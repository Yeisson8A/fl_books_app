import 'dart:convert';
import 'models.dart';

class SeriesInfo {
    String kind;
    String bookDisplayNumber;
    List<VolumeSery> volumeSeries;

    SeriesInfo({
        required this.kind,
        required this.bookDisplayNumber,
        required this.volumeSeries,
    });

    factory SeriesInfo.fromRawJson(String str) => SeriesInfo.fromJson(json.decode(str));

    factory SeriesInfo.fromJson(Map<String, dynamic> json) => SeriesInfo(
        kind: json["kind"],
        bookDisplayNumber: json["bookDisplayNumber"],
        volumeSeries: List<VolumeSery>.from(json["volumeSeries"].map((x) => VolumeSery.fromJson(x))),
    );
}