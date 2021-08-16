import 'package:contactos/services/auth_service.dart';
import 'package:contactos/widgets/custom_textformfield.dart';
import 'package:contactos/widgets/show_alert.dart';
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

    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 17,
            ),
            Text("Login",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 7,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed finge non solum",
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(height: 15),
            Text(
              "Username",
            ),
            SizedBox(height: 15),
            CustomTextFormField(
              hintText: 'example@gmail.com',
              controller: userController,
            ),
            SizedBox(height: 20),
            Text(
              "Password",
            ),
            SizedBox(height: 15),
            CustomTextFormField(
              hintText: '******',
              controller: passControlller,
            ),
            SizedBox(height: 30),
            Center(
              child: Consumer<AuthService>(builder: (_, authService, __) {
                return RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                  shape: StadiumBorder(),
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: !authService.loading
                      ? () async {
                          if (userController.text.trim().isNotEmpty ||
                              passControlller.text.trim().isNotEmpty) {
                            FocusScope.of(context).unfocus();
                            final loginOk = await authService.login(
                              userController.text.trim(),
                              passControlller.text.trim(),
                            );

                            if (loginOk) {
                              Navigator.pushReplacementNamed(
                                  context, "/contacts_screen");
                            } else {
                              //   mostrar alerta
                              showAlert(
                                context,
                                "Login incorreto",
                                'Verifique seus credencias',
                              );
                            }
                          } else {
                            showAlert(
                              context,
                              "Erro",
                              'Preencha os campos',
                            );
                          }
                        }
                      : null,
                  child: Text("Entrar"),
                );
              }),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
