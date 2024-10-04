import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, required this.onpress});
  String text;
  void Function() onpress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: ElevatedButton(
        onPressed: onpress,
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.orange),
            shadowColor: MaterialStatePropertyAll(Colors.orange),
            elevation: MaterialStatePropertyAll(10)),
        child: Text(text),
      ),
    );
  }
}
