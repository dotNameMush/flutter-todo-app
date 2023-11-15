import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Save JSON data as a String
  Future<void> saveData(String key, Map<String, dynamic> value) async {
    final preferences = await SharedPreferences.getInstance();
    final jsonString = json.encode(value);
    await preferences.setString(key, jsonString);
  }

  // Get JSON data from a String
  Future<Map<String, dynamic>?> getData(String key) async {
    final preferences = await SharedPreferences.getInstance();
    final jsonString = preferences.getString(key);
    if (jsonString != null) {
      return json.decode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  // Delete data by key
  Future<void> deleteData(String key) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }
}
