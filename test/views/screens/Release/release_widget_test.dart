import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_lot_system/views/screens/booking/booking.dart';

void main() {
  testWidgets('Release Widget', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: BookingPage(),
    ));
    expect(find.text('Release'), findsOneWidget);
  });

  testWidgets('Release Field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: BookingPage(),
    ));

    await tester.tap(find.byType(BottomNavigationBar).last);
    await tester.pumpAndSettle();

    final vehicleNumberTextField = find.byKey(const Key('release_vehicle_text_field'));

    expect(vehicleNumberTextField, findsOneWidget);
  });
}
