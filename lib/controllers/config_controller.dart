import 'package:get/get.dart';
import '../base/base.dart';

class ConfigController extends GetxController {
  void init() async {
    await Base.loginController.checkLoginStatus();
  }
}
