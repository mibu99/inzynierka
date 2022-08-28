import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ListViewHomeLayout extends StatefulWidget {
  const ListViewHomeLayout({Key? key}) : super(key: key);

  @override
  ListViewHome createState() {
    return ListViewHome();
  }
}
class ListViewHome extends State<ListViewHomeLayout> {
  // List<String> titles = ["List 1", "List 2", "List 3"];
  // final subtitles = [
  //   "Here is list 1 subtitle",
  //   "Here is list 2 subtitle",
  //   "Here is list 3 subtitle"
  // ];
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: const Text('List of RFID'),
  //         centerTitle: true,
  //         backgroundColor: Colors.blueAccent,
  //       ),
  //       body:
  //    ListView.builder(
  //       itemCount: titles.length,
  //       itemBuilder: (context, index) {
  //         return Card(
  //             child: ListTile(
  //                 onTap: () {
  //                   setState(() {
  //                     titles.add('List ${titles.length+1}');
  //                     subtitles.add('Here is list ${titles.length} subtitle');
  //                   });
  //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                     content: Text('${titles[index]} pressed!'),
  //                   ));
  //                 },
  //                 title: Text(titles[index]),
  //                 subtitle: Text(subtitles[index]),
  //                 leading: const CircleAvatar(),
  //                 ));
  //       }));
  // }

  final databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Connect'),
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              ElevatedButton(
                child: const Text('Create Record'),
                onPressed: () {
                  createRecord();
                },
              ),

              ElevatedButton(
                child: const Text('View Record'),
                onPressed: () {
                  getData();
                },
              ),
              ElevatedButton(
                child: const Text('Update Record'),
                onPressed: () {
                  updateData();
                },
              ),
              ElevatedButton(
                child: const Text('Delete Record'),
                onPressed: () {
                  deleteData();
                },
              ),
            ],
          )
      ), //center
    );
  }

  void createRecord(){
    databaseReference.child("1").set({
      'title': 'Mastering EJB',
      'description': 'Programming Guide for J2EE'
    });
    databaseReference.child("2").set({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
  }
  void getData(){
    databaseReference.once().then((DatabaseEvent databaseEvent) {
      print("read once${databaseEvent.snapshot.value}");
    });
  }

  void updateData(){
    databaseReference.child('1').update({
      'description': 'J2EE complete Reference'
    });
  }

  void deleteData(){
    databaseReference.child('1').remove();
  }
}