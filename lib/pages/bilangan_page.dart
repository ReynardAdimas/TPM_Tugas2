import 'package:flutter/material.dart';

class BilanganPage extends StatefulWidget {
  @override
  _BilanganPageState createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {

  TextEditingController angka = TextEditingController();
  String hasil = "";

  void cekBilangan() {

    int? n = int.tryParse(angka.text);

    // error handling kalau bukan angka
    if (n == null) {
      setState(() {
        hasil = "Input harus berupa angka!";
      });
      return;
    }

    String ganjilGenap;
    String prima;

    // cek ganjil genap
    if (n % 2 == 0) {
      ganjilGenap = "Genap";
    } else {
      ganjilGenap = "Ganjil";
    }

    // cek prima
    int pembagi = 0;

    for (int i = 1; i <= n; i++) {
      if (n % i == 0) {
        pembagi++;
      }
    }

    if (pembagi == 2) {
      prima = "Bilangan Prima";
    } else {
      prima = "Bukan Bilangan Prima";
    }

    setState(() {
      hasil = "Angka $n adalah $ganjilGenap dan $prima";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 254, 254), // monokrom background
      appBar: AppBar(
        title: Text("Bilangan", style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: angka,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan Angka",
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,

                enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
                     ),
                 focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
                 ),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: cekBilangan,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: Text("Cek Bilangan", style: TextStyle(color: Colors.white),),
            ),

            SizedBox(height: 20),

            Text(
              hasil,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            )

          ],
        ),
      ),
    );
  }
}