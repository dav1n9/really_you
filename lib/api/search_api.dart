import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

part 'search_api.g.dart';

@RestApi(baseUrl: "http://3.34.180.104:4000")
abstract class SearchApi {
  factory SearchApi(Dio dio, {String baseUrl}) = _SearchApi;

  @GET("/voice")
  Future<SpamNum> getTasks(@Query("spamNumber") String spamNumber);
}

@JsonSerializable()
class SpamNum {
  String? message;
  int? numOfCall;
  SpamNum({this.message, this.numOfCall});

  factory SpamNum.fromJson(Map<String, dynamic> json) =>
      _$SpamNumFromJson(json);
  Map<String, dynamic> toJson() => _$SpamNumToJson(this);
}

