import 'package:contactos/screens/contact_details.dart';
import 'package:contactos/screens/contacts_screen.dart';
import 'package:contactos/screens/login_screen.dart';
import 'package:contactos/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'login_screen',
        initialRoute: '/login_screen',
        routes: {
          "/login_screen": (_) => LoginScreen(),
          "/contacts_screen": (_) => ContactsScreen(),
        },
      ),
    );
  }
}
