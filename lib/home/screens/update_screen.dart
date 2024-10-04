import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note/backend/create_insert_update.dart';
import 'package:note/constant/server_constant.dart';
import 'package:note/custom/custom_textfield.dart';
import 'package:note/functions/validat.dart';
import 'package:note/home/screens/add_screen.dart';

class UpdateNote extends StatelessWidget {
  UpdateNote({
    super.key,
  });
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentController = TextEditingController();

  File? file;

  @override
  Widget build(BuildContext context) {
    var ar = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(ar['note_image'].toString());
    titlecontroller = TextEditingController(text: ar['note_title'].toString());
    contentController =
        TextEditingController(text: ar['note_content'].toString());
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
                                  },
                                )
                              ]),
                            );
                          });
                    },
                    child: const Text('chose Image')),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  if (formState.currentState!.validate()) {
                    CreateInsertUpdate ciu = CreateInsertUpdate();
                    try {
                      if (file != null) {
                        var response = await ciu.postRequestWithFile(
                            updateNote,
                            {
                              'title': titlecontroller.text,
                              'content': contentController.text,
                              'id': ar['note_id'].toString(),
                              'image': ar['note_image'].toString()
                            },
                            file!);
                        print(response);
                      } else {
                        var response = await ciu.postRequest(
                          updateNote,
                          {
                            'title': titlecontroller.text,
                            'content': contentController.text,
                            'id': ar['note_id'].toString(),
                            'image': ar['note_image'].toString()
                          },
                        );
                        print(response);
                      }
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
