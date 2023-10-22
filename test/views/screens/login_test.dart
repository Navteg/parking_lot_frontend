import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_lot_system/views/screens/login.dart';

void main() {
  testWidgets('description', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginPage(),
    ));
    expect(find.text('Welcome,back!'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets('Login Page Test', (WidgetTester tester) async {
    // Build the LoginPage widget
    await tester.pumpWidget(const MaterialApp(
      home: LoginPage(),
    ));

    final parkingIdTextField = find.byKey(const Key('parking_id_text_field'));
    final passwordTextField = find.byKey(const Key('password_text_field'));

    expect(parkingIdTextField, findsOneWidget);
    expect(passwordTextField, findsOneWidget);

    await tester.enterText(parkingIdTextField, 'your_parking_id');
    await tester.enterText(passwordTextField, 'your_password');

    final loginButton = find.byKey(const Key('login_button'));
    expect(loginButton, findsOneWidget);
  });
}
