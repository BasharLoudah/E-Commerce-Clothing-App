import 'package:e_commerece_app/core/network/api.dart';
import 'package:e_commerece_app/core/network/api_request.dart';
import 'package:e_commerece_app/core/network/api_urls.dart';
import 'package:e_commerece_app/features/home/data/models/data_model.dart';

class ServiceRemoteDataSource {
  Future<List<Service>> fetchServices() async {
    final request = ApiRequest(url: ApiUrls.getServices, body: {});
    final response = await Api.get(request);

    if (response.statusCode == 200) {
      // Parse the response data into a list of Service objects
      return (response.body['data'] as List)
          .map((json) => Service.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch services');
    }
  }

  Future<Map<String, dynamic>> fetchServiceDetails(int serviceId) async {
    final request =
        ApiRequest(url: '${ApiUrls.getServiceDetails}/$serviceId', body: {});
    final response = await Api.get(request);
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Failed to fetch service details');
  }

  Future<void> addService(
      Map<String, dynamic> serviceData, String token) async {
    final request = ApiRequest(url: ApiUrls.storeService, body: serviceData);
    await Api.postWithAuth(request, token);
  }
}
