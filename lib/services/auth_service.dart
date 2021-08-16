import 'dart:convert';
import 'package:contactos/models/token_response.dart';
import 'package:http/http.dart' as http;
import 'package:contactos/globals/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  bool _loading = false;
  TokenResponse tokenResponse;
  final _storage = new FlutterSecureStorage();
  get loading => this._loading;

  set loading(value) {
    this._loading = value;

    notifyListeners();
  }

  //Getters de toekn de form static

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: "access");

    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: "access");
  }

  Future login(String user, String pass) async {
    try {
      loading = true;
      final data = {
        "user": user,
        "pass": pass,
      };

      final response = await http.post(
        "${Environment.apiUrl}/auth/access/",
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final loginResponse = tokenResponseFromJson(response.body);
        this.tokenResponse = loginResponse;
        await this._saveToken(loginResponse.access);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: "access", value: token);
  }

  // Future register(
  //   String user,
  //   String pass,
  // ) async {
  //   try {
  //     loading = true;
  //     final data = {
  //       "user": user,
  //       "pass": pass,
  //     };

  //     final response = await http.post(
  //       "${Environment.apiUrl}/auth/access/",
  //       body: json.encode(data),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       final registerResponse = registerResponseFromJson(response.body);
  //       this.user = registerResponse.user;

  //       await this._saveToken(registerResponse.token);
  //       return true;
  //     } else {
  //       final respBody = jsonDecode(response.body);
  //       print(respBody);
  //       return respBody["msg"];
  //     }
  //   } catch (e) {} finally {
  //     loading = false;
  //   }
  // }

  // Future<bool> isLoggedIn() async {
  //   final token = await this._storage.read(key: "token");
  //   final response =
  //       await http.get('${Environment.apiUrl}/login/renew', headers: {
  //     'Content-Type': 'application/json',
  //     'x-token': token,
  //   });

  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     final loginResponse = loginResponseFromJson(response.body);
  //     this.user = loginResponse.user;

  //     await this._saveToken(loginResponse.token);
  //     return true;
  //   } else {
  //     this._logout();
  //     return false;
  //   }
  // }

  Future _logout() async {
    return await _storage.delete(key: "access");
  }
}
