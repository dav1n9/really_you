// import 'package:json_annotation/json_annotation.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:dio/dio.dart';

// part 'RestClient.g.dart';

// @RestApi(baseUrl: "https://xxx.xx.xx.xxx")
// abstract class RestClient {
//   factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

//   @POST("/example") // 해당 api 경로
//   Future<List<ListResponse>> getListData(
//       @Header("user_id") String userId,
//       @Header("Authorization") String token,
//       @Body() PracticeRequest practiceRequest);
// }


// @JsonSerializable()
// class PracticeRequest {

//   int? id;

//   PracticeRequest({
//     required this.id
//   });

//   factory PracticeRequest.fromJson(Map<String, dynamic> json) => _$PracticeRequestFromJson(json);
//   Map<String, dynamic> toJson() => _$PracticeRequestToJson(this);
// }


// @JsonSerializable()
// class ListResponse {

//   String? name;
//   int? age;
//   String? birth;
//   String? phone;
  
//   ListResponse({
//     required this.name,
//     required this.age,
//     required this.birth,
//     required this.phone
//   });
  
//   factory ListResponse.fromJson(Map<String, dynamic> json) => _$ListResponseFromJson(json);
//   Map<String, dynamic> toJson() => _$ListResponseToJson(this);

// }