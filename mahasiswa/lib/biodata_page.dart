import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BiodataPage extends StatefulWidget {
  @override
  _BiodataPageState createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final TextEditingController npmController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController visiController = TextEditingController();

  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("mahasiswa");

  void simpanData() {
    String npm = npmController.text.trim();
    String nama = namaController.text.trim();
    String visi = visiController.text.trim();

    if (npm.isNotEmpty && nama.isNotEmpty && visi.isNotEmpty) {
      dbRef.push().set({
        "npm": npm,
        "nama": nama,
        "visi": visi,
      }).then((_) {
        Fluttertoast.showToast(msg: "Data berhasil disimpan!");
        npmController.clear();
        namaController.clear();
        visiController.clear();
      }).catchError((onError) {
        Fluttertoast.showToast(msg: "Gagal menyimpan data");
      });
    } else {
      Fluttertoast.showToast(msg: "Semua field wajib diisi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Biodata Mahasiswa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: npmController,
              decoration: InputDecoration(labelText: "NPM"),
            ),
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: visiController,
              decoration: InputDecoration(labelText: "Visi (5 tahun)"),
              maxLines: 3,
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