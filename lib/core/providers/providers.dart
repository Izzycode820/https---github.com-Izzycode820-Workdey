import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workdey_frontend/core/interceptors/auth_interceptor.dart';
import 'package:workdey_frontend/core/interceptors/job_interceptor.dart';
import 'package:workdey_frontend/core/models/applicant_model.dart';
import 'package:workdey_frontend/core/services/applicant_service.dart';
import 'package:workdey_frontend/core/services/auth_service.dart';
import 'package:workdey_frontend/core/services/connectivity_service.dart';
import 'package:workdey_frontend/core/services/get_job_service.dart';
import 'package:workdey_frontend/core/services/post_job_service.dart';
import 'package:workdey_frontend/core/storage/local_cache.dart';
import 'package:workdey_frontend/core/storage/local_cache_impl.dart';


// 1. Basic storage provider
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// 2. token watcher provider
final tokenProvider = FutureProvider<String?>((ref) async {
  final storage = ref.read(secureStorageProvider);
  final token = await storage.read(key: 'access_token');
  debugPrint('🔑 TokenProvider - Current token: ${token != null ? "exists" : "null"}');
  return token;
});

// 3. Local cache provider (depends only on storage)
final localCacheProvider = Provider<LocalCache>((ref) {
  return LocalCacheImpl(ref.read(secureStorageProvider));
});

// 4. Base Dio provider without auth dependencies
final baseDioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.127.64:8000',
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
     // Critical for local development:
    persistentConnection: false,  // Disable connection reuse
    followRedirects: false,
  ));
  

  if (!kIsWeb) {
  dio.interceptors.addAll([
    LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
      requestHeader: true,
    responseHeader: true,
    logPrint: (object) => debugPrint(object.toString())
    ),
     
     //Connection error interceptor
    InterceptorsWrapper(
    onRequest: (options, handler) {
        debugPrint('--> ${options.method} ${options.uri}');
        debugPrint('Headers: ${options.headers}');
    return handler.next(options);
  },
    onError: (error, handler) {
      if (error.type == DioExceptionType.connectionError) {
        debugPrint('🔌 Connection error details: ${error.message}');
        debugPrint('🔌 Error response: ${error.response?.statusCode}');
      }
      return handler.next(error);
    },
  )
    ]);
  }
  return dio;
});



// 5. Auth-enabled Dio provider
final dioProvider = Provider<Dio>((ref) {
  final dio = ref.read(baseDioProvider);
  const storage = FlutterSecureStorage();

  // Clone the Dio instance to avoid mutating the base one
  final authDio = Dio(dio.options)
    ..interceptors.addAll([
      AuthInterceptor(storage),
      JobInterceptor(storage: storage),
    ]);

  return authDio;
});

// 6. Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read(dioProvider));
});
//7. Get JObs service provider
final jobServiceProvider = Provider<JobService>((ref) {
  return JobService(ref.read(dioProvider),
    ref.read(localCacheProvider), // Now properly provided
  );
});

//8. connectivity service provider
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

// 9. Post Job provider
final postJobServiceProvider = Provider<PostJobService>((ref) {
  return PostJobService(ref.read(dioProvider));
});

//applicants service provider
final applicantServiceProvider = Provider<ApplicantService>((ref) {
  return ApplicantService(ref.read(dioProvider));
});

//applicant provider
final jobApplicantsProvider = FutureProvider.family<List<Applicant>, int>((ref, jobId) {
  return ref.read(applicantServiceProvider).getJobApplicants(jobId);
});