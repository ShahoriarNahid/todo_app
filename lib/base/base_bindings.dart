import 'package:get/get.dart';
import 'package:todo_app/controllers/menu_controller.dart';

import '../controllers/image_picker_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/task_controller.dart';
import '../services/network_service.dart';

class BaseBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskController());
    Get.lazyPut(() => MenuController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => ImagePickerController());
    Get.lazyPut(() => ConnectivityService());
  }
}
