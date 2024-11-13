import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_wave/View/EmergencyView.dart';
import 'package:safe_wave/View/ForgotPassword.dart';
import 'package:safe_wave/View/SignUp.dart';
import 'package:safe_wave/View/check_in_view.dart';
import 'package:safe_wave/View/login.dart';
import 'View/home_view.dart';

void main() {
  runApp(SafeWaveApp());
}

class SafeWaveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SafetyGuard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeView()),
        GetPage(name: '/checkin', page: () => CheckInView()),
        GetPage(name: '/EmergencyView', page: () => EmergencyView()),
        GetPage(name: '/signup', page: () => SignUpView()),
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/forgotPassword', page: ()=>ForgotPasswordView())
      ],
      home: HomeView(),
    );
  }
}
