import 'package:flutter/material.dart';

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
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30)),
              child: TextFormField(
                decoration: InputDecoration(
                  focusColor: Colors.transparent,
                  hintText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  errorMaxLines: 1,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30)),
              child: TextFormField(
                decoration: InputDecoration(
                  focusColor: Colors.transparent,
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  errorMaxLines: 1,
                ),
              ),
            ),
            SizedBox(height: 30),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
              shape: StadiumBorder(),
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/contacts_screen');
              },
              child: Text("Entrar"),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Criar conta ?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
