// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/check_in_controller.dart';

class CheckInView extends StatelessWidget {
  final CheckInController checkInController = Get.put(CheckInController());

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
                overflow:
                    TextOverflow.ellipsis, // Handle overflow for small screens
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Check-in Time',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Check-In Time',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              hint: Text(
                'Select a time',
                style: TextStyle(color: Colors.black),
              ),
              items: [
                DropdownMenuItem(
                  value: '5 min',
                  child: Text('5 min', style: TextStyle(color: Colors.black)),
                ),
                DropdownMenuItem(
                  value: '15 min',
                  child: Text('15 min', style: TextStyle(color: Colors.black)),
                ),
                DropdownMenuItem(
                  value: '30 min',
                  child: Text('30 min', style: TextStyle(color: Colors.black)),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  checkInController.updateTime(value);
                }
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  checkInController.confirmSchedule();
                },
                child: Text(
                  'Confirm Schedule',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(() => Text(
                  'Selected Time: ${checkInController.selectedTime.value}',
                  style:
                      TextStyle(color: Colors.black), // Set text color to black
                )),
          ],
        ),
      ),
    );
  }
}
