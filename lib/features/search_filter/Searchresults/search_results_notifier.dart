import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';

class JobResultsNotifier extends StateNotifier<List<Job>> {
  JobResultsNotifier() : super([]);

  void updateResults(List<Job> results) {
    state = results;
  }


void addResults(List<Job> newResults) {
    state = [...state, ...newResults];
  }
}

class WorkerResultsNotifier extends StateNotifier<List<Worker>> {
  WorkerResultsNotifier() : super([]);

  void updateResults(List<Worker> results) {
    state = results;
  }
  void addResults(List<Worker> newResults) {
    state = [...state, ...newResults];
  }
}