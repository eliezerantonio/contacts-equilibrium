// import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:contactos/globals/environment.dart';
import 'package:contactos/models/contacts.dart';
import 'package:contactos/models/contacts_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class ContactsService with ChangeNotifier {
  bool _loading = false;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  get loading => _loading;

  Future<List<Result>> getContacts() async {
    try {
      final response =
          await http.get("${Environment.apiUrl}/contacts", headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${await AuthService.getToken()}'
      });

      final usersResponse = contactsResponseFromJson(response.body);
      return usersResponse.results;
    } catch (e) {
      return [];
    }
  }

  Future save(String name, String email, String phone) async {
    try {
      loading = true;
      final Map<String, dynamic> data = {
        "name": name,
        "email": email,
        "phone": phone,
      };

      final response = await http.post(
        "${Environment.apiUrl}/contacts/",
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await AuthService.getToken()}'
        },
      );
      if (response.statusCode == 201) {
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    } finally {
      loading = false;
    }
  }
}
