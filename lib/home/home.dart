import 'package:flutter/material.dart';
import 'package:note/backend/create_insert_update.dart';
import 'package:note/constant/server_constant.dart';
import 'package:note/home/widgets/note_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CreateInsertUpdate ciu = CreateInsertUpdate();

  @override
  getNode() async* {
    var response = await ciu.postRequest(getNotes, {'user': '2'});
    yield response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'addNote');
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: StreamBuilder(
          stream: getNode(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data as Map<String, dynamic>;
              if (data['data'] == null) {
                return const Center(
                  child: Text(
                    'you don\'t have any note',
                    style: TextStyle(fontSize: 24),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: data['data'].length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'updateNote',
                              arguments: (data['data'][index]
                                  as Map<String, dynamic>));
                        },
                        child: NodeCard(
                            onDelete: () async {
                              var res = await ciu.postRequest(deleteNote, {
                                'id': data['data'][index]['note_id'].toString(),
                                'image':
                                    data['data'][index]['note_image'].toString()
                              });

                              print(res);
                              setState(() {});
                            },
                            title: data['data'][index]['note_title'],
                            content: data['data'][index]['note_content']),
                      );
                    });
              }
            } else {
              return const Text('loading .......');
            }
          },
        ));
  }
}
