import 'package:flutter/material.dart';
import 'dart:math';

class PiramidPage extends StatefulWidget {
  const PiramidPage({super.key});

  @override
  State<PiramidPage> createState() => _PiramidScreenState();
}

class _PiramidScreenState extends State<PiramidPage> {
  final TextEditingController panjangC = TextEditingController();
  final TextEditingController lebarC = TextEditingController();
  final TextEditingController tinggiC = TextEditingController();

  double volume = 0;
  double luas = 0;

  void hitungPiramida() {
    double p = double.tryParse(panjangC.text) ?? 0;
    double l = double.tryParse(lebarC.text) ?? 0;
    double t = double.tryParse(tinggiC.text) ?? 0;

    // Menghitung Volume
    double luasAlas = p * l;
    volume = (1 / 3) * luasAlas * t;

    // Menghitung Luas Permukaan
    double tinggiSegitigaPanjang = sqrt(pow(l / 2, 2) + pow(t, 2));
    double tinggiSegitigaLebar = sqrt(pow(p / 2, 2) + pow(t, 2));

    luas = luasAlas + (p * tinggiSegitigaPanjang) + (l * tinggiSegitigaLebar);

    setState(() {});
  }

  bool isValidInput() {
    if (panjangC.text.isEmpty || lebarC.text.isEmpty || tinggiC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Panjang, Lebar, dan Tinggi harus diisi"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    double? p = double.tryParse(panjangC.text);
    double? l = double.tryParse(lebarC.text);
    double? t = double.tryParse(tinggiC.text);

    if (p == null || l == null || t == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Input Harus Angka"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (p <= 0 || l <= 0 || t <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Nilai Harus Lebih Dari 0"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "Kalkulator Piramida",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),

        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Rumus Piramida Persegi Panjang"),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Volume",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("V = 1/3 × (p × l) × t"),
                        SizedBox(height: 10),
                        Text(
                          "Luas Permukaan",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("L = Luas Alas + Jumlah Luas Sisi Tegak"),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Tutup"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/limas.jpg", height: 250),

            const SizedBox(height: 50),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: panjangC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Panjang",
                      prefixIcon: const Icon(Icons.square_foot),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                
                Expanded(
                  child: TextField(
                    controller: lebarC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Lebar",
                      prefixIcon: const Icon(Icons.square_foot),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            TextField(
              controller: tinggiC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tinggi",
                prefixIcon: const Icon(Icons.height),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 50),

            ElevatedButton(
              onPressed: () {
                if (isValidInput()) {
                  hitungPiramida();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text("Hitung", style: TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 30),

            Card(
              color: Colors.grey[100],
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Hasil Perhitungan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text("Volume: ${volume.toStringAsFixed(2)}"),
                    Text("Luas Permukaan: ${luas.toStringAsFixed(2)}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
