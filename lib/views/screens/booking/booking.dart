import 'package:flutter/material.dart';
import 'package:parking_lot_system/data/storage/key_value_storage_impl.dart';
import 'package:parking_lot_system/utils/theme.dart';
import 'package:parking_lot_system/views/screens/booking/booking_widget.dart';
import 'package:parking_lot_system/views/screens/release/release_widget.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  static const List<Widget> _widgetOptions = <Widget>[
    BookingWidget(),
    ReleaseWidget(
      key: Key('release_detail_page'),
    ),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.grayThemeLight,
      appBar: AppBar(
        title: const Text(
          'Parking Lot System',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              KeyValueStorageImpl().deleteAll();
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases_outlined),
            label: 'Release',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorTheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
