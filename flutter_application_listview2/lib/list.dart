// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'data/pacient.dart';

class listView extends StatefulWidget {
  List<Pacient> pacients;

  listView({Key? key, required this.pacients}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<listView> createState() => _listViewState(pacients: pacients);
}

class _listViewState extends State<listView> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
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
                leading: const Icon(
                  Icons.account_box,
                  color: Colors.purple,
                ),
                title: Text(paciente.name),
                subtitle: Text(paciente.sex),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.purple,
                    onPressed: () {
                      openDialog(paciente);
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

  Future openDialog(Pacient pacient) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Dados do Paciente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                autofocus: true,
                controller: controller,
              ),
              TextField(
                autofocus: true,
                controller: controller2,
              ),
            ],
          ),
          actions: [
            Column(
              children: <Widget>[
                TextButton(
                  child: const Text('ADICIONAR'),
                  onPressed: submit(pacient),
                ),
              ],
            ),
          ],
        ),
      );

  submit(Pacient paciente) {
    _update(paciente);
    Navigator.of(context).pop();
    controller.clear();
    controller2.clear();
  }

  _update(Pacient paciente) {
    setState(() {
      paciente.name = controller.text;
      paciente.sex = controller2.text;
    });
  }
}
