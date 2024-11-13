import 'package:get/get.dart';
import '../Model/emergency_feature.dart';

class HomeController extends GetxController {
  // Reactive list of emergency features
  var emergencyFeatures = <EmergencyFeature>[].obs;

  @override
  void onInit() {
    super.onInit();
    // loadEmergencyFeatures();
  }

  // void loadEmergencyFeatures() {
  //   // Mock data, in a real app you could fetch data from an API
  //   emergencyFeatures.value = [
  //     EmergencyFeature(name: 'Location Alert', description: 'Send location to contacts.'),
  //     EmergencyFeature(name: 'Voice Activation', description: 'Activate with voice command.'),
  //   ];
  // }
}
