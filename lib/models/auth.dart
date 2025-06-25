import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tiktok_app/config.dart';
import '../models/user.dart';

class AuthService {
  static bool isLogin = false;
  static String baseUrl = Config.apiBaseUrl;

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  static Future<bool> register(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/regist'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Register failed: ${response.body}');
      return false;
    }
  }

  static Future<bool> login(String phone, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"phone": phone, "password": password}),
    );
    if (response.statusCode == 200) {
      print(response.body);
      final data = json.decode(response.body);
      print(data);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', data['user']['id'].toString());

      return true;
    } else {
      print('Login failed: ${response.body}');
      return false;
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    // print(userJson);
    if (userJson != null) {
      return User.fromJson(json.decode(userJson));
    } else {
      return null;
    }
  }
}
