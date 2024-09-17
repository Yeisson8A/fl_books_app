import 'dart:convert';

class PanelizationSummary {
    bool containsEpubBubbles;
    bool containsImageBubbles;

    PanelizationSummary({
        required this.containsEpubBubbles,
        required this.containsImageBubbles,
    });

    factory PanelizationSummary.fromRawJson(String str) => PanelizationSummary.fromJson(json.decode(str));

    factory PanelizationSummary.fromJson(Map<String, dynamic> json) => PanelizationSummary(
        containsEpubBubbles: json["containsEpubBubbles"],
        containsImageBubbles: json["containsImageBubbles"],
    );
}