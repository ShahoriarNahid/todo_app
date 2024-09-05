import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../helpers/k_log.dart';

class ConnectivityService extends GetxController {
  var isConnected = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await streamConnection();
  }

  Future<void> streamConnection() async {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile)) {
        kLog('Mobile network available');

        kLog('Mobile network available.');
      } else if (result.contains(ConnectivityResult.wifi)) {
        kLog('Wi-fi is available');

        // Wi-fi is available.
        // Note for Android:
        // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
      } else if (result.contains(ConnectivityResult.ethernet)) {
        // Ethernet connection available.
      } else if (result.contains(ConnectivityResult.vpn)) {
        // Vpn connection active.
        // Note for iOS and macOS:
        // There is no separate network interface type for [vpn].
        // It returns [other] on any device (also simulator)
      } else if (result.contains(ConnectivityResult.bluetooth)) {
        // Bluetooth connection available.
      } else if (result.contains(ConnectivityResult.other)) {
        // Connected to a network which is not in the above mentioned networks.
        kLog(
            'Connected to a network which is not in the above mentioned networks');
      } else if (result.contains(ConnectivityResult.none)) {
        kLog('No available network types');
        {
          Get.snackbar('Info', 'No available network types',
              colorText: Colors.black,
              backgroundColor: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              maxWidth: 190,
              duration: Duration(seconds: 3));
          //statements;
        }
        // No available network types
      }
    });
  }
}
