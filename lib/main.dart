import 'package:contactos/screens/contact_details.dart';
import 'package:contactos/screens/contacts_screen.dart';
import 'package:contactos/screens/login_screen.dart';
import 'package:contactos/screens/splash_screen.dart';
import 'package:contactos/services/auth_service.dart';
import 'package:contactos/services/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactsService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contactos',
        initialRoute: '/splash_screen',
        routes: {
          "/login_screen": (_) => LoginScreen(),
          "/contacts_screen": (_) => ContactsScreen(),
          "/contact_detail": (_) => ContactDetails(),
          "/splash_screen": (_) => SplashScreen()
        },
      ),
    );
  }
}
