import 'package:flutter/material.dart';
import 'dart:math';

class PiramidPage extends StatefulWidget {
  const PiramidPage({super.key});

  @override
  State<PiramidPage> createState() => _PiramidScreenState();
}

class _PiramidScreenState extends State<PiramidPage> {

  final TextEditingController sisiC = TextEditingController();
  final TextEditingController tinggiC = TextEditingController();

  double volume = 0;
  double luas = 0;

  void hitungPiramida() {
    double s = double.tryParse(sisiC.text) ?? 0;
    double t = double.tryParse(tinggiC.text) ?? 0;

    double luasAlas = s * s;
    volume = (1 / 3) * luasAlas * t;

    double tinggiSisi = sqrt(pow(s / 2, 2) + pow(t, 2));
    luas = luasAlas + (2 * s * tinggiSisi);

    setState(() {});
  }

  void errorHandling() {
    if (sisiC.text.isEmpty || tinggiC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Alas dan Tinggi harus diisi"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    double? s = double.tryParse(sisiC.text);
    double? t = double.tryParse(tinggiC.text);

    if (s == null || t == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Input Harus Angka"),
          backgroundColor: Colors.red, 
          ),
      );
      return;
    }

    if (s <= 0 || t <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Nilai Harus Lebih Dari 0"),
          backgroundColor: Colors.red,
          ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "Kalkulator Piramida",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
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
                    title: const Text("Rumus Piramida"),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Volume",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "V = 1/3 × luas alas × tinggi",
                        ),

                        SizedBox(height: 10),

                        Text(
                          "Luas Permukaan"
                        ),

                        Text(
                          "L = s² + 2s√((s/2)² + t²)"
                        ),
                      ],
                    ),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, 
                        child: const Text("Tutup"),
                      )
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

            Image.asset(
              "assets/images/limas.jpg",
              height: 250,
            ),

            const SizedBox(height: 50),

            TextField(
              controller: sisiC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Alas",
                prefixIcon: const Icon(Icons.square_foot),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),                
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: tinggiC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tinggi",
                prefixIcon: const Icon(Icons.square_foot),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),    
              ),
            ),

            const SizedBox(height: 100),

            ElevatedButton(
              onPressed: () {
                hitungPiramida();
                errorHandling();  
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
              ),
              child: const Text(
                "Hitung",
                style: TextStyle(fontSize: 16),
              ),
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
            )

          ],
        ),
      ),
    );
  }
}