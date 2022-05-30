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
  String dropdownValue = '';
  List<Pacient> pacients;

  _listViewState({required this.pacients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pacients.length,
      itemBuilder: (context, index) {
        final paciente = pacients[index];
        controller = TextEditingController(text: paciente.name);
        dropdownValue = paciente.sex;
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
                      openDialogEdit();
                      setState(() {
                        paciente.name = controller.text;
                        paciente.sex = dropdownValue;
                      });
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

  Future openDialogEdit() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return AlertDialog(
                title: const Text('Dados do Paciente'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      decoration:
                          const InputDecoration(hintText: 'Digite o nome'),
                      controller: controller,
                    ),
                    Row(
                      children: [
                        const Text('Sexo'),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['Feminino', 'Masculino']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  Column(
                    children: <Widget>[
                      TextButton(
                        child: const Text('SALVAR'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              );
            }),
          );
        },
      );
}
