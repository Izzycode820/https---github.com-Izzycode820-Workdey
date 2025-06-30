import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/services/dio_exceptions.dart';
import 'package:workdey_frontend/core/storage/local_cache.dart';
import 'package:workdey_frontend/features/auth/login/login_utils.dart';

class JobService {
  final Dio _dio;
  final LocalCache _cache;

  JobService(this._dio, this._cache);

  Future<PaginatedResponse<Job>> fetchJobs({
    int page = 1,
    bool forceRefresh = false,
    
  }) async {
    debugPrint('🌐 Fetching jobs page $page (forceRefresh: $forceRefresh)');
    await AuthUtils.printCurrentToken();

    // Try cache first if not forcing refresh and it's first page
    if (!forceRefresh && page == 1) {
      debugPrint('🔍 Checking cache for jobs');
      final cachedJobs = await _cache.getCachedJobs();
      if (cachedJobs != null && cachedJobs.isNotEmpty) {
        debugPrint('✅ Using cached jobs (${cachedJobs.length} items)');
        return PaginatedResponse(
          count: cachedJobs.length,
          results: cachedJobs,
          next: null,
        previous: null,
        );
      }
    }

    try {
      
      debugPrint('📡 Making network request for jobs page $page');
      final response = await _dio.get(
        '/api/v1/jobs/',
        queryParameters: {'page': page},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (kDebugMode) {
        debugPrint('✅ Jobs fetched successfully');
        debugPrint('Response data: ${response.data}');
      }

      // Handle empty or invalid response structure
    final responseData = response.data as Map<String, dynamic>;
    if (responseData['results'] == null || !(responseData['results'] is List)) {
      debugPrint('⚠️ Invalid response structure - returning empty results');
      return PaginatedResponse<Job>(
        count: 0,
        results: [],
        next: null,
        previous: null,
      );
    }

      final paginatedResponse = PaginatedResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => Job.fromJson(json as Map<String, dynamic>),
      );

      // Cache only first page
      if (page == 1) {
        debugPrint('💾 Caching jobs (${paginatedResponse.results.length} items)');
        await _cache.saveJobs(paginatedResponse.results);
      }

      
      
      return paginatedResponse;
     } on DioException catch (e) {
      debugPrint('❌ Error fetching jobs: ${e.message}');

       // Handle 404 specifically
    if (e.response?.statusCode == 404) {
      debugPrint('🔍 Page $page not found - returning empty results');
      return PaginatedResponse<Job>(
        count: 0,
        results: [],
        next: null,
        previous: null,
      );
    }
      
      // Fallback to cache if offline
      if (e.type == DioExceptionType.connectionError) {
        debugPrint('🌐 Offline - trying cache fallback');
        final cachedJobs = await _cache.getCachedJobs();
        if (cachedJobs != null) {
          debugPrint('✅ Using cached jobs as fallback (${cachedJobs.length} items)');
          return PaginatedResponse(
            count: cachedJobs.length,
            results: cachedJobs,
            next: null,
            previous: null,
          );
        }
      }
      throw DioExceptions.fromDioError(e);
    }
  }

      Future<PaginatedResponse<Job>> fetchJobsByLocation({
        int page = 1,
        bool forceRefresh = false,
        String? city,
        String? district,
      }) async {
        final params = {
          'page': page,
          if (city != null) 'city': city,
          if (district != null) 'district': district,
        };

 try {
        final response = await _dio.get(
          '/api/v1/jobs/',
          queryParameters: params,
          options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
        );

        final responseData = response.data as Map<String, dynamic>;
        if (responseData['results'] == null || !(responseData['results'] is List)) {
          debugPrint('⚠️ Invalid response structure - returning empty results');
          return PaginatedResponse<Job>(
            count: 0,
            results: [],
            next: null,
            previous: null,
          );
        }
        
        final paginatedResponse = PaginatedResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => Job.fromJson(json as Map<String, dynamic>),
      );

      // Cache only first page
      if (page == 1) {
        debugPrint('💾 Caching jobs (${paginatedResponse.results.length} items)');
        await _cache.saveJobs(paginatedResponse.results);
      }

      return paginatedResponse;
      }on DioException catch (e) {
      debugPrint('❌ Error fetching jobs: ${e.message}');

      // Handle 404 specifically
    if (e.response?.statusCode == 404) {
      debugPrint('🔍 Page $page not found - returning empty results');
      return PaginatedResponse<Job>(
        count: 0,
        results: [],
        next: null,
        previous: null,
      );
    }
      
      // Fallback to cache if offline
      if (e.type == DioExceptionType.connectionError) {
        debugPrint('🌐 Offline - trying cache fallback');
        final cachedJobs = await _cache.getCachedJobs();
        if (cachedJobs != null) {
          debugPrint('✅ Using cached jobs as fallback (${cachedJobs.length} items)');
          return PaginatedResponse(
            count: cachedJobs.length,
            results: cachedJobs,
            next: null,
            previous: null,
          );
        }
      }
      throw DioExceptions.fromDioError(e);
    }
  }
      

  Future<Job> getJobDetails(String jobId) async {
    debugPrint('🔍 Fetching details for job $jobId');
    try {
      // Check cache first
      final cachedJob = await _cache.getJobDetails(jobId);
      if (cachedJob != null) {
        debugPrint('✅ Using cached job details');
        return cachedJob;
      }

      // Fetch from network
      debugPrint('🌐 Making network request for job details');
      final response = await _dio.get(
        '/api/v1/jobs/$jobId/',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      final job = Job.fromJson(response.data);
      debugPrint('💾 Caching job details');
      await _cache.saveJobDetails(job);
      return job;
    } on DioException catch (e) {
      debugPrint('❌ Error fetching job details: ${e.message}');
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<void> applyForJob(String jobId) async {
    debugPrint('📝 Applying for job $jobId');
    try {
      await _dio.post(
        '/api/v1/jobs/$jobId/apply/',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      debugPrint('✅ Application successful');
      await _cache.invalidateJobApplications();
      debugPrint('♻️ Invalidated job applications cache');
    } on DioException catch (e) {
      debugPrint('❌ Error applying for job: ${e.message}');
      throw DioExceptions.fromDioError(e);
    }
  }


  Future<List<Job>?> getCachedJobs() async {
    debugPrint('🔍 Checking for cached jobs');
    final jobs = await _cache.getCachedJobs();
    debugPrint(jobs != null 
      ? '✅ Found ${jobs.length} cached jobs' 
      : '❌ No cached jobs found');
    return jobs;
  }
}