import 'package:get/get.dart';

class SearchNumController extends GetxController {
  RxString message = ''.obs;
  RxInt spam = 0.obs;

  void setMessage(String m) {
    message.value = m;
  }

  void setSpam(int s) {
    spam.value = s;
  }

  void reset() {
    message.value = '';
    spam.value = 0;
  }
}
