import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../base/base.dart';
import '../helpers/k_text.dart';
import '../helpers/route.dart';

class ImagePickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: KText(
          text: 'Capture Image',
          color: Colors.white,
          bold: true,
        ),
        leading: IconButton(
            onPressed: () {
              back();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return Base.imagePickerController.selectedImagePath.value == ''
                  ? KText(text: 'No image selected')
                  : Image.file(
                      File(Base.imagePickerController.selectedImagePath.value),
                      width: 200,
                      height: 200,
                    );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Base.imagePickerController.pickImage(ImageSource.camera);
              },
              child: KText(text: 'Capture Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Base.imagePickerController.pickImage(ImageSource.gallery);
              },
              child: KText(text: 'Select from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
