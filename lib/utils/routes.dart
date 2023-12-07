import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ui/ui/DonorInfo.dart';
import 'package:ui/ui/auth.dart';
import 'package:ui/ui/book_appointment.dart';
import 'package:ui/ui/home.dart';
import 'package:ui/ui/login.dart';
import 'package:ui/ui/patient.dart';
import 'package:ui/ui/register.dart';
import 'package:ui/ui/splashscreen.dart';

class Routers {
  static final routes = [
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/registration', page: () => RegistrationScreen()),
    GetPage(name: '/home', page: () => Home()),
    GetPage(name: '/donor', page: () => DonorInfoScreen()),
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/patient', page: () => PatientInfoScreen()),
    GetPage(name: "/auth", page: () => AuthControl()),
    GetPage(name: '/donorbook', page: () => DonorAppointmentScreen()),
  ];
}
