// import 'package:http/http.dart' as http;

import 'package:contactos/globals/environment.dart';
import 'package:contactos/models/contacts.dart';
import 'package:contactos/models/contacts_response.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class ContactsProvider {
  Future<List<Result>> getUsers() async {
    try {
      final response = await http.get("${Environment.apiUrl}/contacts",
          headers: {
            "Content-type": "application/json",
            'x-token': await AuthService.getToken()
          });

      final usersResponse = contactsResponseFromJson(response.body);
      return usersResponse.results;
    } catch (e) {
      return [];
    }
  }
}
