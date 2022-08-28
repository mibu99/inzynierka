import 'package:flutter/material.dart';

class Access extends StatefulWidget {
  const Access({Key? key}) : super(key: key);


  @override
  _AccessState createState() => _AccessState();
}



class _AccessState extends State<Access> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Access'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),

    );


  }
}