import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
}
