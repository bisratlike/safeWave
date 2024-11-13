import 'package:get/get.dart';
import 'check_in_controller.dart';

class EmergencyController extends GetxController {
  var isListening = false.obs;
  
  // Reference to CheckInController
  final CheckInController checkInController = Get.find();

  void toggleListening(bool value) {
    isListening.value = value;
  }

  void handleEmergency() {
    // Handle emergency button tap (e.g., send alert)
  }

  void checkIn() {
    // This could trigger additional logic if needed
  }
}
