import 'package:animate_do/animate_do.dart';
import 'package:contactos/models/contacts.dart';
import 'package:contactos/services/contacts_service.dart';
import 'package:contactos/widgets/custom_textformfield.dart';
import 'package:contactos/widgets/loading_screen.dart';
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
      backgroundColor: contacts.isEmpty ? Colors.white : Colors.white,
      body:
          SafeArea(child: contacts.isEmpty ? LoadingScreen() : buildBody(size)),
    );
  }

  Widget buildBody(Size size) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          leading: Container(),
          expandedHeight: 180.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: _header(),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => ClipRRect(
              child: Column(
                children: [
                  SizedBox(height: 6),
                  index % 2 == 0
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child:
                              contactTile(contacts[index], 'assets/avatar.gif'))
                      : contactTile(contacts[index], 'assets/avatar2.gif'),
                  SizedBox(height: 6),
                ],
              ),
            ),
            childCount: this.contacts.length,
          ),
        ),
      ],
    );
  }

  Widget contactTile(Result contact, String url) {
    return FadeInDownBig(
      child: GestureDetector(
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
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(url),
                        ),
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
      ),
    );
  }

  Widget _header() {
    return FadeInUp(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20.0),
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
          ],
        ),
      ),
    );
  }

  Future modalSave() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    // final contactService = context.read<ContactsService>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content:
                Consumer<ContactsService>(builder: (_, contactService, __) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: FadeIn(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          shape: StadiumBorder(),
                          color: Colors.black,
                          textColor: Colors.white,
                          onPressed: !contactService.loading
                              ? () async {
                                  if (emailController.text.isNotEmpty &&
                                      phoneController.text.isNotEmpty &&
                                      nameController.text.isNotEmpty) {
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
                                  } else {
                                    showAlert(
                                      context,
                                      "Erro",
                                      'Preencha os campos',
                                    );
                                  }
                                }
                              : null,
                          child: Text("Salvar"),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }

  void _getContacts() async {
    this.contacts = await userService.getContacts();

    setState(() {});
    _refreshController.refreshCompleted();
  }
}
