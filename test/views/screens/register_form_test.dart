import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_lot_system/views/screens/login.dart';
import 'package:parking_lot_system/views/screens/register.dart';

void main() {
  testWidgets('Register Form Page', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: RegisterPage(),
    ));
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('Register Field', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: RegisterPage(),
    ));
    final floorsTextField = find.byKey(const Key('floors_text_field'));
    final smallVehicleTextField =
        find.byKey(const Key('small_slots_text_field'));
    final mediumVehicleTextField =
        find.byKey(const Key('medium_slots_text_field'));
    final largeVehicleTextField =
        find.byKey(const Key('large_slots_text_field'));
    final xLargeVehicleTextField =
        find.byKey(const Key('xlarge_slots_text_field'));
    final passwordTextField =
        find.byKey(const Key('register_password_text_field'));

    expect(floorsTextField, findsOneWidget);
    expect(smallVehicleTextField, findsOneWidget);
    expect(mediumVehicleTextField, findsOneWidget);
    expect(largeVehicleTextField, findsOneWidget);
    expect(xLargeVehicleTextField, findsOneWidget);
    expect(passwordTextField, findsOneWidget);
  });

  testWidgets('Register Button', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: RegisterPage(),
    ));
    final registerButton = find.byKey(const Key('register_button'));
    expect(registerButton, findsOneWidget);
  });

  testWidgets('Redirect to login', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: const RegisterPage(),
      routes: {
        "/login": (_) => const LoginPage(),
      },
    ));
    await widgetTester.tap(find.byType(InkWell).last);
    await widgetTester.pumpAndSettle();
    expect(find.text('Welcome,back!'), findsOneWidget);
  });

  testWidgets('Register form click, with empty password,and floors',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: const RegisterPage(),
      routes: {
        "/login": (_) => const LoginPage(),
      },
    ));
    await widgetTester.tap(find.byType(ElevatedButton));
    await widgetTester.pumpAndSettle(); // Wait for the widget tree to settle
    // expect(find.text('Welcome, back!'),
    //     findsOneWidget); // Assert that the expected text is found
  });

  testWidgets('Register form click, with empty password,and floors',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: const RegisterPage(),
      routes: {
        "/login": (_) => const LoginPage(),
      },
    ));

    final textField = find.byKey(const Key('floors_text_field'));
    await widgetTester.enterText(textField, '1');

    final passWord = find.byKey(const Key('register_password_text_field'));
    await widgetTester.enterText(passWord, 'password');

    await widgetTester.tap(find.byType(ElevatedButton));
    await widgetTester.pumpAndSettle();
  });
}
