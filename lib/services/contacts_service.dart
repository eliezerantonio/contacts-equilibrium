// import 'package:http/http.dart' as http;

import 'package:contactos/globals/environment.dart';
import 'package:contactos/models/contacts.dart';
import 'package:contactos/models/contacts_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class ContactsService with ChangeNotifier {
  Future<List<Result>> getContacts() async {
    try {
      final response =
          await http.get("${Environment.apiUrl}/contacts", headers: {
        "Content-type": "application/json",
        'Authorization bearer': await AuthService.getToken(),
      });

      final usersResponse = contactsResponseFromJson(response.body);
      print(usersResponse.results);
      return usersResponse.results;
    } catch (e) {
      return [];
    }
  }
}
