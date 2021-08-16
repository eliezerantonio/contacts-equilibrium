import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key key,
    this.hintText,
    this.controller,
    this.initialValue,
    this.isPassword = false,
    this.type,
  }) : super(key: key);
  final String hintText;
  final TextEditingController controller;
  final String initialValue;
  final TextInputType type;
  bool isPassword;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(13)),
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        obscureText: isPassword,
        initialValue: initialValue,
        decoration: InputDecoration(
          focusColor: Colors.transparent,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding:
              const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
          errorMaxLines: 1,
        ),
      ),
    );
  }
}
