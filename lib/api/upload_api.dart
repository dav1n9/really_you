import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'upload_api.g.dart';

@RestApi(baseUrl: "https://64cc-211-194-113-31.ngrok-free.app")
abstract class UploadApi {
  factory UploadApi(Dio dio, {String baseUrl}) = _UploadApi;

  @POST("/audio")
  Future<String> getAudio(@Part(fileName: 'file') File file);
}
