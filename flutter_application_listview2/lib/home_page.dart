import 'package:flutter/material.dart';
import 'popup.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pacient> pacients = [];

  void _incrementList() {
    setState(() {
      pacients.add(Pacient(),);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
      ),
      body:_buildListView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
					showDialog(
              context: context,
              builder: (BuildContext context) => const PopupWidget(),
					);
        },
        tooltip: 'Adicionar',
        child: const Icon(Icons.add),
      ),
    );
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
                title: Text('a'),
                subtitle: const Text("Clique para mais informações"),
                onTap: () {},
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.purple,
                    onPressed: () {
                      setState(() {
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
}
class Pacient {
}