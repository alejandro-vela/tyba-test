import '../network/endpoint.dart';

class UniversityEndpoint extends Endpoint {
  UniversityEndpoint();

  @override
  Method get method => Method.get;

  @override
  String get path => 'FE-Engineer-test/universities.json';
}
