import 'package:dio/dio.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/features/search_filter/worker_filters_enums.dart';

class WorkerSearchService {
  final Dio _dio;

  WorkerSearchService(this._dio);

  Future<List<Worker>> search({
    String? query,
    WorkerCategory? category,
    List<String>? skills,
    String? location,
    List<WorkerAvailability>? availability,
    int page = 1,
  }) async {

    try{

    final params = {
      if (query != null) 'search': query,
      if (category != null) 'category': category.name.toUpperCase(),
      if (skills != null) 'skills[]': skills,
      if (location != null) 'location': location,
      if (availability != null) 
        'availability[]': availability.map((a) => a.apiValue).toList(),
      'page': page,  
    };

    final response = await _dio.get('/api/v1/worker-search/', queryParameters: params);
    
    // Handle 404 for pagination
    if (response.statusCode == 404 && page > 1) {
      return [];
    }

    final data = response.data as Map<String, dynamic>;
    if (data['results'] == null) return [];
    
    return (data['results'] as List).map((json) => Worker.fromJson(json)).toList();
  } on DioException catch (e) {
    if (e.response?.statusCode == 404 && page > 1) {
      return []; // No more pages available
    }
    rethrow;
  }
}

}