import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckInController extends GetxController {
  var selectedTime = ''.obs;

  void updateTime(String time) {
    selectedTime.value = time;
  }

  void confirmSchedule() {
    if (selectedTime.isEmpty) {
      Get.snackbar(
        "Error",
        "Please select a check-in time.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Success",
        "Check-in time scheduled for $selectedTime.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
