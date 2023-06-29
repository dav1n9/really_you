import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/retrofit.dart';

@RestApi(baseUrl: "")
abstract class UploadApi {
  String base_url = dotenv.get("base_url");

  //factory UploadApi(Dio dio, {String baseUrl}) = _UploadApi;
}
