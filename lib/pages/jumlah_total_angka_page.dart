import 'package:flutter/material.dart';

class JumlahTotalAngkaPage extends StatefulWidget {
  const JumlahTotalAngkaPage({super.key});

  @override
  State<JumlahTotalAngkaPage> createState() => _JumlahTotalAngkaPageState();
}

class _JumlahTotalAngkaPageState extends State<JumlahTotalAngkaPage> {

  final TextEditingController angkaController = TextEditingController();
  double total = 0;

  void hitungTotal() {

    String input = angkaController.text.trim();

    if (input.isEmpty) {
      tampilkanError("Input tidak boleh kosong");
      return;
    }

    List<String> angkaList = input.split(" ");

    double hasil = 0;

    try {

      for (var angka in angkaList) {

        if (angka.isEmpty) continue;

        hasil += double.parse(angka);

      }

      setState(() {
        total = hasil;
      });

    } catch (e) {
      tampilkanError("Input hanya boleh berisi angka");
    }
  }

  void tampilkanError(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Jumlah Total Angka",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                children: [

                  const Text(
                    "Masukkan angka (pisahkan dengan spasi)",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: angkaController,
                    style: const TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                      hintText: "Contoh: 1 2.5 3 4.7",
                      hintStyle: const TextStyle(color: Colors.grey),

                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: hitungTotal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("Hitung"),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Total: $total",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}