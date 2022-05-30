import 'package:flutter/material.dart';
import 'data/pacient.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  String dropdownValue = 'Feminino';
  List<Pacient> pacients = [];

  @override
  Widget build(BuildContext context) {
    dropdownValue = 'Feminino';
    controller.clear();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
      ),
      body: _buildListView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await openDialog();
          setState(() {
            _incrementList();
          });
        },
        tooltip: 'Adicionar',
        child: const Icon(Icons.add),
      ),
    );
  }

  openDialog() => showDialog(
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
                      child: const Text('ADICIONAR'),
                      onPressed: () {
                        _incrementList();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          }),
        );
      });

  _incrementList() {
    setState(() {
      pacients.add(Pacient(name: controller.text, sex: dropdownValue));
    });
  }

  ListView _buildListView(BuildContext context) {
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
                    onPressed: () {},
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
