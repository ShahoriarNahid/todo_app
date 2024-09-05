import 'package:get/get.dart';
import 'package:todo_app/controllers/menu_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/task_controller.dart';
import '../controllers/image_picker_controller.dart';
import '../services/network_service.dart';

class Base {
  Base._();
  static final taskController = Get.find<TaskController>();
  static final menuController = Get.find<MenuController>();
  static final loginController = Get.find<LoginController>();
  static final imagePickerController = Get.find<ImagePickerController>();
  static final connectivityService = Get.find<ConnectivityService>();

}
