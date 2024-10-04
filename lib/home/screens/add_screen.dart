import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note/backend/create_insert_update.dart';
import 'package:note/constant/server_constant.dart';
import 'package:note/custom/custom_textfield.dart';
import 'package:note/functions/validat.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

GlobalKey<FormState> formState = GlobalKey();
TextEditingController titlecontroller = TextEditingController();
TextEditingController contentController = TextEditingController();
File? file;
String? imageText;

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('new note')),
      body: Form(
        key: formState,
        child: Column(
          children: [
            CustomTextField(
              hintText: 'note tilte',
              myController: titlecontroller,
              valid: (p0) => validateTextField(p0!, 200, 5),
            ),
            CustomTextField(
                hintText: 'note content',
                myController: contentController,
                valid: (val) => validateTextField(val!, 1000, 10)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: Column(children: [
                                const Text(
                                  'chose image from ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  child: const Text(
                                    'from Gallery',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  onTap: () async {
                                    XFile? xfile = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    file = File(xfile!.path);
                                    imageText = '';
                                    setState(() {});
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  child: const Text(
                                    'from Camera',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  onTap: () async {
                                    XFile? xfile = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    file = File(xfile!.path);
                                    imageText = '';
                                    setState(() {});
                                  },
                                )
                              ]),
                            );
                          });
                    },
                    child: const Text('chose Image')),
                imageText == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          imageText!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  if (file == null) {
                    imageText = 'please chose image';
                    setState(() {});
                  }
                  if (formState.currentState!.validate() && file != null) {
                    CreateInsertUpdate ciu = CreateInsertUpdate();
                    try {
                      var response = await ciu.postRequestWithFile(
                          addNotes,
                          {
                            'title': titlecontroller.text,
                            'content': contentController.text,
                            'user': '2'
                          },
                          file!);
                      print(response);
                    } catch (e) {
                      print('-------------------------------');
                      print(e.toString());
                    }
                  }
                },
                child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
