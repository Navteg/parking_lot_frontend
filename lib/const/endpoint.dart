class Endpoint {
  static const String baseUrl = 'https://parking-lot-api-64l4.onrender.com';

  static const int connectionTimeout = 25000;
  static const int receiveTimeout = 15000;

  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String bookSlot = '$baseUrl/book-slot';
  static const String releaseSlot = '$baseUrl/release-slot';
}
