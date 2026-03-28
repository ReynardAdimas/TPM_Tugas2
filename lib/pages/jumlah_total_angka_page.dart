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

    for (var item in angkaList) {

      if (item.isEmpty) continue;

      // coba parse langsung (angka biasa & desimal)
      double? nilai = double.tryParse(item);

      if (nilai != null) {
        hasil += nilai;
      } else {
        // ambil digit satu-satu
        for (int i = 0; i < item.length; i++) {
          if (RegExp(r'[0-9]').hasMatch(item[i])) {
            hasil += double.parse(item[i]);
          }
        }
      }
    }

    setState(() {
      total = hasil;
    });
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Stack(
        children: [

          /// BACKGROUND +
          Positioned(
            top: 80,
            left: 30,
            child: Text(
              "+",
              style: TextStyle(
                fontSize: 120,
                color: Colors.white.withOpacity(0.05),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// BACKGROUND -
          Positioned(
            bottom: 120,
            right: 40,
            child: Text(
              "-",
              style: TextStyle(
                fontSize: 120,
                color: Colors.white.withOpacity(0.05),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// CONTENT
          Padding(
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
                          hintText: "Contoh: abc 1 2.5 xyz 3",
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
        ],
      ),
    );
  }
}