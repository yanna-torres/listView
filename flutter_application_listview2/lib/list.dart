// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'pacient.dart';

class listView extends StatefulWidget {
  List<Pacient> pacients;

  listView({Key? key, required this.pacients}) : super(key: key);

  @override
  State<listView> createState() => _listViewState(pacients: pacients);
}

class _listViewState extends State<listView> {
  List<Pacient> pacients;

  _listViewState({required this.pacients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pacients.length,
      itemBuilder: (context, index) {
        final paciente = pacients[index];
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                ),
                title: Text(paciente.name),
                subtitle: const Text("Clique para mais informações"),
                onTap: () {},
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.purple,
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.purple,
                    onPressed: () {
                      setState(() {
                        pacients.remove(paciente);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
