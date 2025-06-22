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
     final data = response.data as Map<String, dynamic>;
  final results = data['results'] as List;
  
  return results.map((json) => Worker.fromJson(json)).toList();
}

}