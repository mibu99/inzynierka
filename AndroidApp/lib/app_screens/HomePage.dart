import 'package:flutter/material.dart';
import 'List.dart';
import 'Access.dart';
import 'Bluetooth.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC-RFID'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'NAME: ',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'EMAIL: ',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2.0, color: Colors.black),
                      left: BorderSide(width: 2.0, color: Colors.black),
                      right: BorderSide(width: 2.0, color: Colors.black),
                      bottom: BorderSide(width: 2.0, color: Colors.black),
                    ),
                    color: Colors.white,),
                  child: const Text('Welcome to RFID Access System', textAlign: TextAlign.right, style: TextStyle(color: Colors.black)
                  ),
                )
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ListViewHomeLayout()),);},
                  child: Column(
                    children: const <Widget>[
                      Icon(Icons.list_alt_sharp, size: 100.00,),
                      Text("List")
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const Access()),);},
                  child: Column(
                    children: const <Widget>[
                      Icon(Icons.check_circle, size: 100.00,),
                      Text("Access")
                    ],
                  ),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const Bluetooth()),);},
                  child: Column(
                    children: const <Widget>[
                      Icon(Icons.bluetooth, size: 100.00,),
                      Text("Settings")
                    ],
                  ),
                ),
              ]
          ),
        ],
      ),
    );
  }
}
