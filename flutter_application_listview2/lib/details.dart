// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_listview2/home_page.dart';

class DetailsPage extends StatefulWidget {
  final int index;
  Pacient paciente;

  // ignore: use_key_in_widget_constructors
  DetailsPage(
    this.index,
    this.paciente,
  );

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.paciente.name),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              widget.paciente.name,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
