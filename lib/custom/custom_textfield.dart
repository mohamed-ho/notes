import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      required this.myController,
      required this.valid});
  String hintText;
  TextEditingController myController;
  GlobalKey mykey = GlobalKey();
  String? Function(String?) valid;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: valid,
        key: mykey,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: Colors.blue)),
          hintText: hintText,
        ),
        controller: myController,
      ),
    );
  }
}
