import 'package:flutter/material.dart';

class BilanganPage extends StatefulWidget {
  @override
  _BilanganPageState createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {

  TextEditingController angka = TextEditingController();
  String hasil = "";

  void cekBilangan() async {

    String input = angka.text.replaceAll(",", ".");

    // 👉 CEK DESIMAL (RASIONAL)
    if (input.contains(".")) {
      double? n = double.tryParse(input);

      if (n == null) {
        setState(() {
          hasil = "Input harus berupa angka!";
        });
        return;
      }

      setState(() {
        hasil = "Angka $input merupakan bilangan rasional";
      });
      return;
    }

    // 👉 PAKAI BIGINT
    BigInt angkaBesar;

    try {
      angkaBesar = BigInt.parse(input);
    } catch (e) {
      setState(() {
        hasil = "Input harus berupa angka!";
      });
      return;
    }

    // 👉 GANJIL / GENAP (CEPAT)
    String ganjilGenap =
        (angkaBesar % BigInt.from(2) == BigInt.zero) ? "Genap" : "Ganjil";

    // tampilkan dulu biar UI ga kosong
    setState(() {
      hasil = "Angka $input adalah $ganjilGenap, sedang mengecek prima...";
    });

    await Future.delayed(Duration(milliseconds: 100));

    // 👉 CEK PRIMA TANPA FREEZE UI
    bool isPrima = true;

    if (angkaBesar <= BigInt.one) {
      isPrima = false;
    } else {
      BigInt i = BigInt.from(2);

      while (i * i <= angkaBesar) {
        if (angkaBesar % i == BigInt.zero) {
          isPrima = false;
          break;
        }
        i += BigInt.one;
      }
    }

    String prima =
        isPrima ? "Bilangan Prima" : "Bukan Bilangan Prima";

    setState(() {
      hasil = "Angka $input adalah $ganjilGenap dan $prima";
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