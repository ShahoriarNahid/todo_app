import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/left_side_bar_model.dart';


class MenuController1 extends GetxController {
  final globalKey = GlobalKey<ScaffoldState>();

  List<LeftSidebar> leftSidebar = [];

  List<LeftSidebar> getLeftDrawer() {
    return leftSidebar = [
      LeftSidebar(
        title: 'My Personal Data',
        iconPath: 'assets/icons/my_personal_data_icon.png',
        children: [
          LeftSidebarChildren(title: 'Update My Profile'),

        ],
      ),


      LeftSidebar(
        title: 'App Settings',
        iconPath: 'assets/icons/app_settings_icon.png',
        children: [
          LeftSidebarChildren(title: 'App Settings'),

        ],
      ),
    ];
  }



//left
  void pushMenuLeft(String title) {
    switch (title) {
    // case '':
    //   back();
    //   return push();

      default:
        {
          Get.snackbar(
            'Attention!!',
            'Development in progress',
            colorText:Colors.black,
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            dismissDirection: DismissDirection.horizontal,
            maxWidth: 190,
          );
          //statements;
        }
    }
  }

//right
  void pushMenu(String title) {
    switch (title) {
    // case '':
    //   back();
    //   return push();

      default:
        {
          Get.snackbar('Attention!!',
              'Development in progress',
              colorText:Colors.black,
              backgroundColor: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              maxWidth: 190,
              duration: Duration(seconds: 3));
          //statements;
        }
    }
  }
}
