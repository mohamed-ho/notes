import 'package:flutter/material.dart';
import 'package:note/backend/create_insert_update.dart';
import 'package:note/constant/server_constant.dart';
import 'package:note/custom/custom_button.dart';
import 'package:note/custom/custom_textfield.dart';
import 'package:note/functions/validat.dart';

class Signup extends StatefulWidget {
  Signup({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(children: [
            Image.asset('assets/images/note.png'),
            CustomTextField(
                valid: (val) {
                  validateTextField(val!, 30, 2);
                  return null;
                },
                hintText: 'name',
                myController: widget.userNameController),
            CustomTextField(
              valid: (val) {
                validateTextField(val!, 30, 6);
                return null;
              },
              hintText: 'email',
              myController: widget.emailController,
            ),
            CustomTextField(
              valid: (val) {
                validateTextField(val!, 30, 3);
                return null;
              },
              hintText: 'password',
              myController: widget.passwordController,
            ),
            CustomButton(
                text: 'Login',
                onpress: () async {
                  CreateInsertUpdate ciu = CreateInsertUpdate();
                  var res = await ciu.postRequest(signupUrl, {
                    'username': widget.userNameController.text,
                    'email': widget.emailController.text,
                    'password': widget.passwordController.text
                  });
                  if (res['status'] == 'succes') {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home', (route) => false);
                  } else {
                    print('you have error');
                  }
                }),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: InkWell(
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('login', (route) => false);
                  }),
            )
          ])),
    );
  }
}
