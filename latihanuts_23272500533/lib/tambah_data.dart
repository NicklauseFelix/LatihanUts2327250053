import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TambahDataPage extends StatefulWidget {
  @override
  _TambahDataPageState createState() => _TambahDataPageState();
}

class _TambahDataPageState extends State<TambahDataPage> {
  final namaController = TextEditingController();
  final jkController = TextEditingController();
  final umurController = TextEditingController();
  final kasusController = TextEditingController();

  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('narapidana');

  void simpanData() {
    dbRef.push().set({
      'nama': namaController.text,
      'jk': jkController.text,
      'umur': umurController.text,
      'kasus': kasusController.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Data")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: jkController,
              decoration: InputDecoration(labelText: "Jenis Kelamin"),
            ),
            TextField(
              controller: umurController,
              decoration: InputDecoration(labelText: "Umur"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: kasusController,
              decoration: InputDecoration(labelText: "Kasus"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: simpanData,
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}