import 'dart:convert';

class VolumeSery {
    String seriesId;
    String seriesBookType;
    int orderNumber;

    VolumeSery({
        required this.seriesId,
        required this.seriesBookType,
        required this.orderNumber,
    });

    factory VolumeSery.fromRawJson(String str) => VolumeSery.fromJson(json.decode(str));

    factory VolumeSery.fromJson(Map<String, dynamic> json) => VolumeSery(
        seriesId: json["seriesId"],
        seriesBookType: json["seriesBookType"],
        orderNumber: json["orderNumber"],
    );
}