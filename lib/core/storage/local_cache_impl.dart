// local_cache_impl.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/storage/local_cache.dart';

class LocalCacheImpl implements LocalCache {
  final FlutterSecureStorage _storage;
  static const _jobsPrefix = 'jobs_';
  static const _jobDetailsPrefix = 'job_';
  static const _lastUpdatedPrefix = 'last_updated_';
  static const _cacheDuration = Duration(hours: 1);

  LocalCacheImpl(this._storage);


   @override
  Future<void> set(String key, dynamic value, {Duration? duration}) async {
    try {
      final jsonString = jsonEncode(value);
      await _storage.write(key: key, value: jsonString);
      
      // Store expiration time if duration is provided
      if (duration != null) {
        final expiryTime = DateTime.now().add(duration).toIso8601String();
        await _storage.write(key: '${key}_expiry', value: expiryTime);
      }
    } catch (e) {
      debugPrint('Error setting cache for key $key: $e');
    }
  }

   @override
  Future<dynamic> get(String key) async {
    try {
      // Check if key has expiry
      final expiryString = await _storage.read(key: '${key}_expiry');
      if (expiryString != null) {
        final expiryTime = DateTime.parse(expiryString);
        if (DateTime.now().isAfter(expiryTime)) {
          // Cache expired, remove it
          await remove(key);
          return null;
        }
      }

      final jsonString = await _storage.read(key: key);
      if (jsonString == null) return null;
      
      return jsonDecode(jsonString);
    } catch (e) {
      debugPrint('Error getting cache for key $key: $e');
      return null;
    }
  }

  @override
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
    await _storage.delete(key: '${key}_expiry'); // Also remove expiry
  }
  
  @override
  Future<void> write<T>(String key, T value) async {
    if (value is String || value is List<int>) {
      await _storage.write(key: key, value: jsonEncode(value));
    } else {
      throw UnsupportedError('Type not supported');
    }
  }

  @override
  Future<T?> read<T>(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;
    
    if (T == List<int>) {
      return jsonDecode(value) as T;
    }else if (T == String) {
      return value as T;
    }
    throw UnsupportedError('Type not supported');
  }

   @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<List<Job>?> getJobs({
    String? searchQuery,
    Map<String, dynamic>? filters,
    int? page,
  }) async {
    final key = _buildCacheKey(searchQuery, filters, page);
    return _getJobsByKey(key);
  }

  Future<List<Job>?> _getJobsByKey(String key) async {
    final json = await _storage.read(key: key);
    final lastUpdatedKey = '$_lastUpdatedPrefix$key';
    final lastUpdatedString = await _storage.read(key: lastUpdatedKey);

    if (json == null || lastUpdatedString == null) return null;

    final lastUpdated = DateTime.parse(lastUpdatedString);
    if (DateTime.now().difference(lastUpdated) > _cacheDuration) {
      await _storage.delete(key: key);
      await _storage.delete(key: lastUpdatedKey);
      return null;
    }

    try {
      final List<dynamic> jsonList = jsonDecode(json);
      return jsonList.map((jobJson) => Job.fromJson(jobJson)).toList();
    } catch (e) {
      await _storage.delete(key: key);
      await _storage.delete(key: lastUpdatedKey);
      return null;
    }
  }

  @override
  Future<void> saveJobs(
    List<Job> jobs, {
    String? searchQuery,
    Map<String, dynamic>? filters,
    int? page,
  }) async {
    final key = _buildCacheKey(searchQuery, filters, page);
    await _saveJobsByKey(key, jobs);
  }

  Future<void> _saveJobsByKey(String key, List<Job> jobs) async {
    final lastUpdatedKey = '$_lastUpdatedPrefix$key';
    final jsonList = jobs.map((job) => job.toJson()).toList();
    final jsonString = jsonEncode(jsonList);

    await _storage.write(key: key, value: jsonString);
    await _storage.write(
      key: lastUpdatedKey,
      value: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<List<Job>?> getCachedJobs() async {
    debugPrint('🔄 Checking cache storage...');
    final keys = await _storage.readAll().then((map) => map.keys);
    final jobKeys = keys.where((k) => k.startsWith(_jobsPrefix) && !k.startsWith(_lastUpdatedPrefix));
   // debugPrint('🔑 Storage keys: ${keys.keys}');

    if (jobKeys.isEmpty) return null;

    var mostRecentKey = '';
    DateTime? mostRecentDate;
    
    for (final key in jobKeys) {
      final lastUpdatedKey = '$_lastUpdatedPrefix$key';
      final lastUpdatedString = await _storage.read(key: lastUpdatedKey);
      if (lastUpdatedString != null) {
        final date = DateTime.parse(lastUpdatedString);
        if (mostRecentDate == null || date.isAfter(mostRecentDate)) {
          mostRecentDate = date;
          mostRecentKey = key;
        }
      }
    }
    
    return mostRecentKey.isNotEmpty ? _getJobsByKey(mostRecentKey) : null;
  }

@override
  Future<void> clearJobsCache() async {
    final keys = await _storage.readAll().then((map) => map.keys);
    final jobKeys = keys.where((k) => k.startsWith(_jobsPrefix) || 
                               k.startsWith(_lastUpdatedPrefix));
    for (final key in jobKeys) {
      await _storage.delete(key: key);
    }
  }

  @override
  Future<DateTime?> getLastUpdatedTime() async {
    final cached = await getCachedJobs();
    if (cached == null) return null;
    
    final keys = await _storage.readAll().then((map) => map.keys);
    final lastUpdatedKey = keys.firstWhere(
      (k) => k.startsWith(_lastUpdatedPrefix),
      orElse: () => '',
    );
    
    if (lastUpdatedKey.isEmpty) return null;
    final lastUpdatedString = await _storage.read(key: lastUpdatedKey);
    return lastUpdatedString != null ? DateTime.parse(lastUpdatedString) : null;
  }

  @override
Future<Job?> getJobDetails(String jobId) async {
  final key = '$_jobDetailsPrefix$jobId';
  final lastUpdatedKey = '$_lastUpdatedPrefix$key';
  final json = await _storage.read(key: key);
  final lastUpdatedString = await _storage.read(key: lastUpdatedKey);

  if (json == null || lastUpdatedString == null) return null;

  final lastUpdated = DateTime.parse(lastUpdatedString);
  if (DateTime.now().difference(lastUpdated) > _cacheDuration) {
    await _storage.delete(key: key);
    await _storage.delete(key: lastUpdatedKey);
    return null;
  }

  try {
    return Job.fromJson(jsonDecode(json));
  } catch (e) {
    await _storage.delete(key: key);
    await _storage.delete(key: lastUpdatedKey);
    return null;
  }
}

  @override
  Future<void> saveJobDetails(Job job) async {
    final key = '$_jobDetailsPrefix${job.id}';
    final lastUpdatedKey = '$_lastUpdatedPrefix$key';
    final jsonString = jsonEncode(job.toJson());

    await _storage.write(key: key, value: jsonString);
    await _storage.write(
      key: lastUpdatedKey,
      value: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<void> invalidateJobApplications() async {
    final keys = await _storage.readAll().then((map) => map.keys);
    final applicationKeys = keys.where((k) => k.startsWith('application_'));
    for (final key in applicationKeys) {
      await _storage.delete(key: key);
    }
  }

  @override
  Future<void> invalidateSavedJobs() async {
    final keys = await _storage.readAll().then((map) => map.keys);
    final savedJobKeys = keys.where((k) => k.startsWith('saved_job_'));
    for (final key in savedJobKeys) {
      await _storage.delete(key: key);
    }
  }

String _buildCacheKey(
  String? searchQuery,
  Map<String, dynamic>? filters,
  int? page,
) {
  // Build filter string if filters exist
  final filterString = filters?.entries
          .map((e) => '${e.key}:${e.value}')
          .join('&') ??
      '';
  
  // Combine all parts with underscores
  return [
    '${_jobsPrefix}q:${searchQuery ?? ''}', // query part
    'f:$filterString',                      // filter part
    'p:${page ?? 1}'                        // page part
  ].join('_');
}

  // Additional helper methods
  Future<void> clearAllCache() async {
    await _storage.deleteAll();
  }

  Future<void> clearExpiredCache() async {
    final now = DateTime.now();
    final allKeys = await _storage.readAll().then((map) => map.keys);
    
    for (final key in allKeys) {
      if (key.startsWith(_lastUpdatedPrefix)) {
        final lastUpdatedString = await _storage.read(key: key);
        if (lastUpdatedString != null) {
          final lastUpdated = DateTime.parse(lastUpdatedString);
          if (now.difference(lastUpdated) > _cacheDuration) {
            final dataKey = key.replaceFirst(_lastUpdatedPrefix, '');
            await _storage.delete(key: dataKey);
            await _storage.delete(key: key);
          }
        }
      }
    }
  }
}