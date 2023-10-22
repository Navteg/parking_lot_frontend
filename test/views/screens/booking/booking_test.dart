import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_lot_system/views/screens/booking/booking.dart';

void main() {
  testWidgets('Booking Screen', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: BookingPage(),
    ));
    expect(find.text('Booking'), findsOneWidget);
  });

  testWidgets('Booking Field', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: BookingPage(),
    ));
    final vehicleNumberTextField = find.byKey(const Key('vehicle_text_field'));
    final vehicleTypeField = find.byKey(const Key('vehicle_type_list'));

    expect(vehicleNumberTextField, findsOneWidget);
    expect(vehicleTypeField, findsOneWidget);
  });
}
