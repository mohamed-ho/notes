import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:note/backend/create_insert_update.dart';
import 'package:note/constant/server_constant.dart';
import 'package:note/custom/custom_button.dart';
import 'package:note/custom/custom_textfield.dart';
import 'package:note/functions/validat.dart';

class Login extends StatefulWidget {
  Login({super.key});
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Form(
            key: widget.formState,
            child: ListView(children: [
              Image.asset('assets/images/note.png'),
              CustomTextField(
                valid: (val) {
                  return validateTextField(val!, 30, 3);
                },
                hintText: 'email',
                myController: widget.emailController,
              ),
              CustomTextField(
                valid: (val) {
                  return validateTextField(val!, 30, 3);
                },
                hintText: 'password',
                myController: widget.passwordController,
              ),
              CustomButton(
                  text: 'Login',
                  onpress: () async {
                    if (widget.formState.currentState!.validate()) {
                      CreateInsertUpdate ciu = CreateInsertUpdate();
                      var res = await ciu.postRequest(loginUrl, {
                        'email': widget.emailController.text,
                        'password': widget.passwordController.text
                      });
                      if (res['status'] == 'succes') {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home', (route) => false);
                      } else {
                        print('your email or password wrong');
                      }
                    } else {
                      print('the validate is not valid ...........');
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: InkWell(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('signup');
                    }),
              )
            ]),
          )),
    );
  }
}
