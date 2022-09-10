import 'dart:io';

abstract class SharedConfiguration {
  static const network = Network._();
}

class Network {
  const Network._();

  final Map<String, String> headers = const {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  final String baseUrlDevelopment = 'tyba-assets.s3.amazonaws.com';
  final String baseUrlImageTyba =
      'https://tyba.com.co/wp-content/uploads/2022/07/tyba-logo.svg';
}
