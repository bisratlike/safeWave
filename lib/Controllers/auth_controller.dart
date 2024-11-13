import 'package:get/get.dart';
import 'dart:convert';
import '../Model/user_model.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var user = UserModel(email: "", password: "", fullName: "").obs;

  // Sign-up logic
  Future<void> signUp(UserModel userModel) async {
    isLoading(true);
    try {
      // Simulate API call to register the user
      await Future.delayed(Duration(seconds: 2));

      // Convert the user model to JSON and log it (this would typically be sent to a server)
      String userJson = jsonEncode(userModel.toJson());
      print('User Registered: $userJson');

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
      } else {
        Get.snackbar("Error", "Invalid email or password.");
      }
      
    } catch (e) {
      print("Login Error: $e");
      Get.snackbar("Error", "Login failed.");
    } finally {
      isLoading(false);
    }
  }

  // Reset password logic
  Future<void> resetPassword(String email) async {
    isLoading(true);
    try {
      // Simulate API call for password reset (replace with actual logic)
      await Future.delayed(Duration(seconds: 2));

      // You would typically call your API here and send an email with the reset link
      print('Password reset requested for: $email');

      // Simulating success
      Get.snackbar(
          "Success", "Password reset link has been sent to your email.");
    } catch (e) {
      print("Password Reset Error: $e");
      // Handle error (e.g., network issues, invalid email)
      Get.snackbar("Error", "Failed to reset password.");
    } finally {
      isLoading(false);
    }
  }
}
