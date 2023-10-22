import 'package:flutter/material.dart';
import 'package:parking_lot_system/utils/theme.dart';
import 'package:parking_lot_system/views/screens/booking/booking.dart';
import 'package:parking_lot_system/views/screens/login.dart';
import 'package:parking_lot_system/views/screens/register.dart';
import 'package:parking_lot_system/views/screens/release/release_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorTheme.primary),
        fontFamily: 'roboto',
        useMaterial3: true,
      ),
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/booking": (context) => const BookingPage(),
        "/release": (context) => const ReleaseWidget(),
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
