import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'k_text.dart';

class Global {
  Global._();

  static void confirmDialog({required void Function()? onConfirmed}) async {
    return Get.defaultDialog(
      contentPadding: EdgeInsets.zero,
      barrierDismissible: true,
      backgroundColor: Colors.white,
      title: '',
      content: SizedBox(
        height: 200,
        width: 320,
        child: Column(
          children: [
            Icon(
              Icons.warning,
              color: Colors.red.withOpacity(.6),
              size: 60,
            ),
            SizedBox(
              height: 22,
            ),
            KText(
              text: 'Are you sure to do this?',
              fontSize: 17,
              bold: false,
            ),
            SizedBox(
              height: 22,
            ),
            Row(
              children: [
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.red)),
                    child: KText(
                      text: 'Cancel',
                      bold: true,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: TextButton(
                    onPressed: onConfirmed,
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.blueAccent)),
                    child: KText(
                      text: 'Confirm',
                      bold: true,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(flex: 1, child: SizedBox()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
