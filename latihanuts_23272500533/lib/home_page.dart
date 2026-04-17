import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'tambah_data.dart';

class HomePage extends StatelessWidget {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('narapidana');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data Narapidana")),
      body: StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (!snapshot.hasData ||
              snapshot.data!.snapshot.value == null) {
            return Center(child: Text("Belum ada data"));
          }

          Map data = snapshot.data!.snapshot.value as Map;

          List items = [];
          data.forEach((key, value) {
            items.add(value);
          });

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(items[index]['nama']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("JK: ${items[index]['jk']}"),
                      Text("Umur: ${items[index]['umur']}"),
                      Text("Kasus: ${items[index]['kasus']}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TambahDataPage()),
          );
        },
      ),
    );
  }
}