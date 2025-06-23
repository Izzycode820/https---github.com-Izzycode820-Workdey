// import 'dart:convert';

// import 'package:workdey_frontend/shared/enum/search_type.dart';

// class FilterStorageService {
//   final SharedPreferences _prefs;

//   FilterPreferences getFilters(SearchType type) {
//     final json = _prefs.getString(_keyFor(type));
//     return json != null 
//         ? FilterPreferences.fromJson(jsonDecode(json))
//         : FilterPreferences.empty();
//   }

//   Future<void> saveFilters(SearchType type, FilterPreferences prefs) async {
//     await _prefs.setString(_keyFor(type), jsonEncode(prefs.toJson()));
//   }

//   String _keyFor(SearchType type) => '${type.name}_filters';
// }