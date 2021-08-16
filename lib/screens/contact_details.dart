import 'package:animate_do/animate_do.dart';
import 'package:contactos/models/contacts.dart';
import 'package:contactos/services/contacts_service.dart';
import 'package:contactos/widgets/custom_textformfield.dart';
import 'package:contactos/widgets/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactDetails extends StatelessWidget {
  ContactDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Result contact = ModalRoute.of(context).settings.arguments;
    final nameController = TextEditingController(text: contact.name);
    final phoneController = TextEditingController(text: contact.phone);
    final emailController = TextEditingController(text: contact.email);
    final contactService = context.watch<ContactsService>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: size.height * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInRightBig(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  FadeInUp(
                    from: 7.0,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Text(
                        contact.name[0],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(contact.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  Text(contact.email,
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
            Spacer(),
            Container(
              height: size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FadeInUp(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Icon(
                                Icons.call,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Icon(
                                Icons.message,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Icon(
                                Icons.email,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "Nome",
                        controller: nameController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "E-mail",
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "Telefone",
                        controller: phoneController,
                      ),
                      SizedBox(height: 30),
                      RaisedButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                        shape: StadiumBorder(),
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: !contactService.loading
                            ? () async {
                                final ok = await contactService.update(
                                    nameController.text,
                                    emailController.text,
                                    phoneController.text,
                                    contact.id);
                                if (ok) {
                                  showAlert(
                                    context,
                                    "Sucesso",
                                    'Dados Atualizados ',
                                  );
                                } else {
                                  showAlert(
                                    context,
                                    "Cadastro incorreto",
                                    'Verifique os dados',
                                  );
                                }
                              }
                            : null,
                        child: Text("Editar"),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
