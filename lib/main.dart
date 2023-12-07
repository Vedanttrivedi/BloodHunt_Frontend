import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/controllers/auth_controller.dart';
import 'package:ui/controllers/splash_controller.dart';
import 'package:ui/ui/DonorInfo.dart';
import 'package:ui/ui/auth.dart';
import 'package:ui/ui/book_appointment.dart';
import 'package:ui/ui/home.dart';
import 'package:ui/ui/login.dart';
import 'package:ui/ui/patient.dart';
import 'package:ui/ui/register.dart';
import 'package:ui/ui/splashscreen.dart';
import 'package:ui/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BloodHunt',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        getPages: Routers.routes);
  }
}
