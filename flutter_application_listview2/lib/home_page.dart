import 'package:flutter/material.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController controller;
  List<Pacient> pacients = [];
  String name = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  void _incrementList(String nome) {
    setState(() {
      pacients.add(
        Pacient(
          name: nome,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
      ),
      body: _buildListView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final name = await openDialog();
          if (name == null || name.isEmpty) return;
          setState(() {
            this.name = name;
          });
          _incrementList(name);
        },
        tooltip: 'Adicionar',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Dados do Paciente'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Digite o nome'),
            controller: controller,
            onSubmitted: (_) => submit(),
          ),
          actions: [
            TextButton(
              child: const Text('ADICIONAR'),
              onPressed: submit,
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }

  ListView _buildListView(BuildContext context) {
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
                title: Text(
                  paciente.name,
                ),
                subtitle: const Text("Clique para mais informações"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => DetailsPage(index, paciente)),
                    ),
                  );
                },
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

class Pacient {
  String name;

  Pacient({
    required this.name,
  });
}
