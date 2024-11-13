import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/user_model.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> signUp(UserModel user) async {
  isLoading.value = true;
  try {
    var response = await http.post(
      Uri.parse('http://localhost:3003/api/v1/user/signup'), // Replace with the correct URL if necessary
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()), // Include username in the request body
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Log for debugging

<<<<<<< HEAD
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        Get.snackbar("Success", "Sign up successful!", snackPosition: SnackPosition.BOTTOM);
        Get.toNamed('/login');
=======
      // Assuming successful sign-up
      user.value = userModel;
      Get.snackbar("Success", "User signed up successfully!");
      Get.offNamed('/checkin');
    } catch (e) {
      print("Sign-up Error: $e");
      Get.snackbar("Error", "Something went wrong during sign up.");
    } finally {
      isLoading(false);
    }
  }

  // Login logic
  Future<void> login(String email, String password) async {
    isLoading(true);
    try {
      // Simulate API call for login (you'd typically authenticate with a backend here)
      await Future.delayed(Duration(seconds: 2));

      // Mock response: if email is 'user@example.com' and password is 'password'
      if (email == 'user@example.com' && password == 'password') {
        // On success, you could store authentication tokens here
        Get.snackbar("Success", "Logged in successfully!");
        Get.offNamed('/checkin');
>>>>>>> cc12cc276f6ef30e561e18ff3954ab47d38faf35
      } else {
        Get.snackbar("Error", data['message'], snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar("Error", "Failed to sign up. Please try again.", snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    Get.snackbar("Error", "Failed to sign up. Please try again.", snackPosition: SnackPosition.BOTTOM);
    print("Error during sign-up: $e");
  } finally {
    isLoading.value = false;
  }
}

  // Login function
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse('http://localhost:3003/api/v1/user/login'), // Replace with your actual login URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      var data = json.decode(response.body);
      if (response.statusCode == 200 && data['success']) {
        Get.snackbar("Success", "Login successful!", snackPosition: SnackPosition.BOTTOM);
        Get.toNamed('/home'); // Navigate to the home page or other page after login
      } else {
        Get.snackbar("Error", data['message'], snackPosition: SnackPosition.BOTTOM);
      }
<<<<<<< HEAD
=======
      
>>>>>>> cc12cc276f6ef30e561e18ff3954ab47d38faf35
    } catch (e) {
      Get.snackbar("Error", "Login failed. Please try again.", snackPosition: SnackPosition.BOTTOM);
      print("Error during login: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Reset password function
  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/reset-password'), // Replace with your actual reset password URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      var data = json.decode(response.body);
      if (response.statusCode == 200 && data['success']) {
        Get.snackbar("Success", "Password reset email sent.", snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", data['message'], snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to reset password. Please try again.", snackPosition: SnackPosition.BOTTOM);
      print("Error during password reset: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
