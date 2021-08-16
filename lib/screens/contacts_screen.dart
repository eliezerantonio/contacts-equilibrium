import 'package:contactos/models/contacts.dart';
import 'package:contactos/services/contacts_service.dart';
import 'package:contactos/widgets/custom_textformfield.dart';
import 'package:contactos/widgets/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final userService = ContactsService();

  List<Result> contacts = [];

  @override
  void initState() {
    super.initState();
    this._getContacts();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _getContacts,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.green[400]),
          waterDropColor: Colors.green[400],
        ),
        child: SafeArea(child: buildBody(size)),
      ),
    );
  }

  Widget buildBody(Size size) {
    return ListView(
      // physics: NeverScrollableScrollPhysics(),
      physics: BouncingScrollPhysics(),
      children: [
        _header(),
        SizedBox(
          height: 7,
        ),
        Container(
          height: (130.0 * this.contacts.length),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Container(
            height: (size.height),
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: 50),
            child: ListView.builder(
              itemCount: this.contacts.length,
              physics: NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => Column(
                children: [
                  SizedBox(height: 6),
                  contactTile(contacts[index]),
                  SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget contactTile(Result contact) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/contact_detail', arguments: contact);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage("assets/avatar.gif")),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        contact.email,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                height: 15,
                width: 15,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Contactos",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              GestureDetector(
                onTap: () {
                  modalSave();
                },
                child: Icon(
                  Icons.add_box_rounded,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              decoration: InputDecoration(
                focusColor: Colors.transparent,
                hintText: 'Procurar',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                    top: 15, left: 10, right: 10, bottom: 15),
                errorMaxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future modalSave() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    // final contactService = context.read<ContactsService>();
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Consumer<ContactsService>(builder: (_, contactService, __) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(8.0),
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30)),
                    child: Icon(
                      Icons.people,
                      size: 30,
                      color: Colors.white,
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
                    type: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: "Telefone",
                    type: TextInputType.phone,
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
                            final ok = await contactService.save(
                                nameController.text,
                                emailController.text,
                                phoneController.text);
                            if (ok) {
                              Navigator.pop(context);
                              _getContacts();
                            } else {
                              showAlert(
                                context,
                                "Cadastro incorreto",
                                'Verifique os dados',
                              );
                            }
                          }
                        : null,
                    child: Text("Salvar"),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            );
          });
        });
  }

  void _getContacts() async {
    this.contacts = await userService.getContacts();

    setState(() {});
    _refreshController.refreshCompleted();
  }
}
