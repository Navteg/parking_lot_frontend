// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:parking_lot_system/const/storage_keys.dart';
import 'package:parking_lot_system/data/storage/key_value_storage_impl.dart';
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
      routes: {
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/booking": (context) => const BookingPage(),
        "/release": (context) => const ReleaseWidget(),
      },
      home: FutureBuilder<bool>(
        future: checkIfLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return const BookingPage();
            } else {
              return const LoginPage();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<bool> checkIfLoggedIn() async {
    final token = await KeyValueStorageImpl().read(StorageKeys.token);
    return token != null;
  }
}
