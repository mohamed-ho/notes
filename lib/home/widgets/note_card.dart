import 'dart:ffi';

import 'package:flutter/material.dart';

class NodeCard extends StatelessWidget {
  NodeCard(
      {super.key,
      required this.title,
      required this.content,
      required this.onDelete});
  String title;
  String content;
  void Function()? onDelete;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber[100],
      child: Row(children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image.asset('assets/images/note.png'),
        ),
        Expanded(
          child: Column(
            children: [Text(title), Text(content)],
          ),
        ),
        InkWell(
          onTap: onDelete,
          child: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        )
      ]),
    );
  }
}
