import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:tyba_test/src/repository/endpoints/university_endpoint.dart';

import '../../../global_locator.dart';
import '../models/university.dart';
import '../network/api_repository.dart';

abstract class UniversityRepository {
  Future<List<UniversityModel>?> getUniversities();
}

class UniversityRepositoryDefault implements UniversityRepository {
  var apiRepository = global<APIRepository>();
  final _logger = global<Logger>();

  @override
  Future<List<UniversityModel>?> getUniversities() async {
    try {
      UniversityEndpoint endpoint = UniversityEndpoint();
      _logger.wtf(endpoint);
      Response response = await apiRepository.request(endpoint: endpoint);
      if (response.statusCode == 200) {
        List<UniversityModel> data = universityModelFromJson(response.body);
        return data;
      } else {
        _logger.e('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }
}
