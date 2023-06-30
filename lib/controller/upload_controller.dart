import 'package:get/get.dart';

class UploadController extends GetxController {
  RxBool uploadVisibility = true.obs;
  RxBool resultVisibility = false.obs;
  RxString result = ''.obs;

  void changeUploadVisibility() {
    uploadVisibility.value = !uploadVisibility.value;
  }

  void changeResultVisibility() {
    resultVisibility.value = !resultVisibility.value;
  }

  void resetVisibility() {
    uploadVisibility.value = true;
    resultVisibility.value = false;
  }

  void resetResult() {
    result.value = '';
  }
}
