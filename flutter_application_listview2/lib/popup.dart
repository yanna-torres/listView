import 'package:flutter/material.dart';

class PopupWidget extends StatefulWidget {
  const PopupWidget({Key? key}) : super(key: key);

  @override
  _PopupWidgetState createState() => _PopupWidgetState();
}

enum menuitem { feminino, masculino }

class _PopupWidgetState extends State<PopupWidget> {
	TextEditingController controller = TextEditingController();
  menuitem? _mitem = menuitem.feminino;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Dados do paciente',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
					Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
	             autofocus: true,
	             decoration: const InputDecoration(hintText: 'Digite o nome'),
	             controller: controller,
	          ),
          ),
          ListTile(
            title: const Text('Feminino'),
            trailing: Radio<menuitem>(
              activeColor: Colors.purple,
              value: menuitem.feminino,
              groupValue: _mitem,
              onChanged: (menuitem? value) {
                setState(() {
                  _mitem = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Maculino'),
            trailing: Radio<menuitem>(
              value: menuitem.masculino,
              activeColor: Colors.purple,
              groupValue: _mitem,
              onChanged: (menuitem? value) {
                setState(() {
                  _mitem = value;
                });
              },
            ),
          ),
          Center(
            child: TextButton(
							child: const Text('SALVAR', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}