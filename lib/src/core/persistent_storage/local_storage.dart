import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/app_constants.dart';

class LocalStorage {
  static SharedPreferences? _prefs;
  
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }
  
  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('LocalStorage not initialized. Call LocalStorage.init() first.');
    }
    return _prefs!;
  }
  
  // Token management
  Future<void> saveToken(String token) async {
    await prefs.setString(AppConstants.tokenKey, token);
  }
  
  String? getToken() {
    return prefs.getString(AppConstants.tokenKey);
  }
  
  Future<void> removeToken() async {
    await prefs.remove(AppConstants.tokenKey);
  }
  
  // User data management
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await prefs.setString(AppConstants.userKey, jsonEncode(userData));
  }
  
  Map<String, dynamic>? getUserData() {
    final userDataString = prefs.getString(AppConstants.userKey);
    if (userDataString != null) {
      return jsonDecode(userDataString) as Map<String, dynamic>;
    }
    return null;
  }
  
  Future<void> removeUserData() async {
    await prefs.remove(AppConstants.userKey);
  }
  
  // Theme management
  Future<void> saveThemeMode(String themeMode) async {
    await prefs.setString(AppConstants.themeKey, themeMode);
  }
  
  String? getThemeMode() {
    return prefs.getString(AppConstants.themeKey);
  }
  
  // Generic methods
  Future<void> saveString(String key, String value) async {
    await prefs.setString(key, value);
  }
  
  String? getString(String key) {
    return prefs.getString(key);
  }
  
  Future<void> saveBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }
  
  bool? getBool(String key) {
    return prefs.getBool(key);
  }
  
  Future<void> saveInt(String key, int value) async {
    await prefs.setInt(key, value);
  }
  
  int? getInt(String key) {
    return prefs.getInt(key);
  }
  
  Future<void> remove(String key) async {
    await prefs.remove(key);
  }
  
  Future<void> clear() async {
    await prefs.clear();
  }
}

