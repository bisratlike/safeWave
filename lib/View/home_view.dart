// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image that covers only the upper part
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 200,
            child: Image.asset(
              'assets/images/3.webp',
              fit: BoxFit.cover,
            ),
          ),
          // Main content
          Align(
            alignment: Alignment.bottomCenter, // Align content to the bottom
            child: Container(
              padding: const EdgeInsets.all(20),
              color:
                  Colors.white, // Optional: Add a semi-transparent background
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  // Logo and SafeWave Text with Gradient and Shadow Effects
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Image (optional)
                      Image.asset(
                        'assets/images/logo.png',
                        height: 50, // Adjust size as needed
                      ),
                      SizedBox(height: 10),
                      // SafeWave Text with Gradient
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: [Colors.blue, Colors.green],
                          ).createShader(bounds);
                        },
                        child: Text(
                          'SafeWave',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'You deserve to be safe!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(() => Column(
                        children: controller.emergencyFeatures.map((feature) {
                          return Text(
                            feature.name,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                      )),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.warning),
                        color: Colors.orange,
                        iconSize: 40,
                        onPressed: () {
                          _showInfoDialog(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.person),
                        color: Colors.blue,
                        iconSize: 40,
                        onPressed: () {
                          _showEmergencyContactInfoDialog(context);
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.offNamed('/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Get started',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("SafeWave Information"),
        content: Text(
            "SafeWave provides quick access to emergency features, helping you stay safe in critical situations. Use the app to set check-in times, send alerts, and more."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      );
    },
  );
}

void _showEmergencyContactInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Emergency Contact Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "You can add emergency contacts to help keep you safe. "
              "The person in the first position will receive a phone call during an emergency, "
              "while the other contacts will receive a text message with your GPS location and "
              "the message 'Help me!'",
            ),
            SizedBox(height: 20),
            Icon(Icons.warning, color: Colors.red, size: 40),
            SizedBox(height: 10),
            Text(
              "Ensure your contacts are informed and ready to assist in case of an emergency.",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Closes the dialog
            },
            child: Text("Got it"),
          ),
        ],
      );
    },
  );
}
