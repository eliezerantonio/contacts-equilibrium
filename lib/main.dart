import 'package:contactos/screens/contacts_screen.dart';
import 'package:contactos/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contactos',
      home: LoginScreen(),
      routes: {
        "/login_screen": (_) => LoginScreen(),
        "/contacts_screen": (_) => ContactsScreen(),
      },
    );
  }
}
