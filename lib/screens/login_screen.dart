import 'package:contactos/services/auth_service.dart';
import 'package:contactos/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(context),
    );
  }

  Container _body(BuildContext context) {
    final userController = TextEditingController();
    final passControlller = TextEditingController();
    final authService = context.watch<AuthService>();
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.gif", width: 250, height: 220),
            // Text("Contact"),
            SizedBox(height: 15),
            CustomTextFormField(
              hintText: 'E-mail',
              controller: userController,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              hintText: 'Pasword',
              controller: passControlller,
            ),
            SizedBox(height: 30),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
              shape: StadiumBorder(),
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () async{
FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                      userController.text.trim(),
                      passControlller.text.trim(),
                    );

                    if (loginOk) {
                      Navigator.pushReplacementNamed(context, "/contacts_screen");
                    } else {
                      //   mostrar alerta
                      showAlert(
                        context,
                        "Login incorreto",
                        'Verifique seus credencias',
                      );
                    }

              },
              child: Text("Entrar"),
            ),
            SizedBox(height: 30),
            Text(
              "Criar conta ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
