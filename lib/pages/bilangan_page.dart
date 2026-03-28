import 'package:flutter/material.dart';

class BilanganPage extends StatefulWidget {
  @override
  _BilanganPageState createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {

  TextEditingController angka = TextEditingController();
  String hasil = "";

  void cekBilangan() {

    // ganti koma jadi titik
    String input = angka.text.replaceAll(",", ".");
    double? n = double.tryParse(input);

    // error handling
    if (n == null) {
      setState(() {
        hasil = "Input harus berupa angka!";
      });
      return;
    }

    // cek desimal (rasional)
    if (input.contains(".")) {
      setState(() {
        hasil = "Angka $input merupakan bilangan rasional";
      });
      return;
    }

    int angkaBulat = n.toInt();

    String ganjilGenap;
    String prima;

    // cek ganjil genap
    if (angkaBulat % 2 == 0) {
      ganjilGenap = "Genap";
    } else {
      ganjilGenap = "Ganjil";
    }

    // cek prima
    int pembagi = 0;

    for (int i = 1; i <= angkaBulat; i++) {
      if (angkaBulat % i == 0) {
        pembagi++;
      }
    }

    if (pembagi == 2) {
      prima = "Bilangan Prima";
    } else {
      prima = "Bukan Bilangan Prima";
    }

    setState(() {
      hasil = "Angka $angkaBulat adalah $ganjilGenap dan $prima";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 254, 254),
      appBar: AppBar(
        title: Text(
          "Bilangan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 8, 8, 8),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: angka,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
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
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text(
                "Cek Bilangan",
                style: TextStyle(color: Colors.white),
              ),
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