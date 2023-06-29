import 'package:get/get.dart';

class UploadController extends GetxController {
  RxBool uploadVisibility = true.obs;

  void changeUploadVisibility() {
    uploadVisibility.value = !uploadVisibility.value;
  }

  void resetUploadVisibility() {
    uploadVisibility.value = true;
  }
}
