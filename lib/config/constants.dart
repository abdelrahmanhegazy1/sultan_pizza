import 'package:flutter/material.dart';

//colors
const kMainColor = Color(0xFFF2FD1B);
const kSecondColor = Color(0xFFA04C3D);
//for screens
const kLogin_Screen = 'login_Screen';
const kRegister_Screen = 'register_Screen';
const kHome_Screen = 'home_Screen';
const kPizza_Screen = 'pizza_Screen';
const kCart_Screen = 'cart_Screen';
const kOrder_Screen = 'order_Screen';
const kHistory_Screen = 'history_Screen';
// for decoration
Map<String, Icon> map = {
  'username': Icon(Icons.person),
  'password': Icon(Icons.vpn_key_sharp),
  'email': Icon(Icons.email),
  'age': Icon(Icons.apps_sharp)
};

InputDecoration getDecorationTextField(String hintText, String textFieldType) {
  return InputDecoration(
    prefixIcon: map[textFieldType],
    hintText: hintText,
    alignLabelWithHint: true,
    hintStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(color: kMainColor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(color: kMainColor, width: 1.0),
    ),
  );
}
