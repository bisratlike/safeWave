// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/Emergency_Controller.dart';
import '../controllers/check_in_controller.dart';


class EmergencyView extends StatelessWidget {
final EmergencyController emergencyController = Get.find<EmergencyController>();
final CheckInController checkInController = Get.find<CheckInController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 153, 180),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 18,
            ),
            SizedBox(width: 20),
            Flexible(
              child: Text(
                'SafeWave',
                style: TextStyle(color: Colors.black, fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            color: Colors.black,
            onPressed: () {
              Get.offNamed('/EmergencyView');
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.black,
            onPressed: () {
              // Navigate to settings or implement settings action
            },
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            color: Colors.black,
            onPressed: () {
              // Implement add contact action
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Emergency Button
            GestureDetector(
              onTap: () {
                emergencyController.handleEmergency();
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Emergency',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Check-in Button
            Obx(() => ElevatedButton(
                  onPressed: () {
                    String checkInMessage = checkInController
                            .selectedTime.isNotEmpty
                        ? 'You will be checked in at ${checkInController.selectedTime.value}.'
                        : 'You will be checked in in 5 minutes by default.';

                    Get.snackbar(
                      "Check-In Scheduled",
                      checkInMessage,
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    checkInController.selectedTime.isNotEmpty
                        ? 'Check me in ${checkInController.selectedTime.value}'
                        : 'Check me in 5 min',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                )),

            SizedBox(height: 30),

            // Background Listening Toggle
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Switch(
                      value: emergencyController.isListening.value,
                      onChanged: (value) {
                        emergencyController.toggleListening(value);
                      },
                      activeColor: Colors.blue,
                    ),
                    Text(
                      "Background Listening",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                )),

            SizedBox(height: 10),

            // Link to change check-in time
            TextButton(
              onPressed: () {
                Get.offNamed('/checkin');
              },
              child: Text(
                "Want to change the check-in time?",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
