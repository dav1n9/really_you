import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

//part 'search_api.g.dart';

@RestApi(baseUrl: "3.34.180.104:4000")
abstract class SearchApi {
  String base_url = dotenv.get("base_url");

  //factory SearchApi(Dio dio, {String baseUrl}) = _SearchApi;

  @GET("/voice")
  Future<Task> getTasks(@Query("spamNumber") String spamNumber);
}

@JsonSerializable()
class Task {
  String massage;
  int numOfCall;
  Task({required this.massage, required this.numOfCall});
  //factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

