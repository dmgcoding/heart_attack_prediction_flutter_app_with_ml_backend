// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class PredicResModel {
  PredicResModelData? data;
  String? error;
  bool isError;
  String msg;

  PredicResModel({
    required this.data,
    required this.error,
    required this.isError,
    required this.msg,
  });

  factory PredicResModel.fromRawJson(String str) =>
      PredicResModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PredicResModel.fromJson(Map<String, dynamic> json) => PredicResModel(
        data: json['data'] == null
            ? null
            : PredicResModelData.fromJson(json["data"]),
        error: json["error"],
        isError: json["isError"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
        "isError": isError,
        "msg": msg,
      };
}

class PredicResModelData {
  String percentage;

  PredicResModelData({
    required this.percentage,
  });

  factory PredicResModelData.fromRawJson(String str) =>
      PredicResModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PredicResModelData.fromJson(Map<String, dynamic> json) =>
      PredicResModelData(
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "percentage": percentage,
      };
}
