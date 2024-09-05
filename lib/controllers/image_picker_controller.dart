
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/helpers/k_log.dart';

class ImagePickerController extends GetxController {
  var selectedImagePath = ''.obs;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      kLog(selectedImagePath.value);
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}