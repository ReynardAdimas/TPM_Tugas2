import 'dart:async';
import 'package:flutter/material.dart';

class UmurPage extends StatefulWidget {
  const UmurPage({super.key});

  @override
  State<UmurPage> createState() => _UmurPageState();
}

class _UmurPageState extends State<UmurPage> {

  DateTime? tanggalLahir;

  int tahun = 0;
  int bulan = 0;
  int hari = 0;
  int jam = 0;
  int menit = 0;
  int detik = 0;

  Timer? timer;

  void mulaiTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      hitungUmur();
    });
  }

  void pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        tanggalLahir = picked;
      });

      mulaiTimer(); // langsung jalan real-time
    }
  }

  void hitungUmur() {

    if (tanggalLahir == null) return;

    DateTime sekarang = DateTime.now();

    Duration selisih = sekarang.difference(tanggalLahir!);

    int totalHari = selisih.inDays;

    tahun = totalHari ~/ 365;
    bulan = (totalHari % 365) ~/ 30;
    hari = (totalHari % 365) % 30;

    int totalJam = selisih.inHours;
    int totalMenit = selisih.inMinutes;
    int totalDetik = selisih.inSeconds;

    jam = totalJam % 24;
    menit = totalMenit % 60;
    detik = totalDetik % 60;

    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel(); // penting biar ga memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Hitung Umur (Real-Time)",
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

                      /// BUTTON PILIH TANGGAL
                      ElevatedButton(
                        onPressed: pilihTanggal,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text("Pilih Tanggal Lahir"),
                      ),

                      const SizedBox(height: 15),

                      /// TAMPIL TANGGAL
                      Text(
                        tanggalLahir == null
                            ? "Belum memilih tanggal"
                            : "${tanggalLahir!.day}-${tanggalLahir!.month}-${tanggalLahir!.year}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// HASIL REAL-TIME
                      const Text(
                        "Umur (Realtime):",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text("Tahun: $tahun",
                          style: const TextStyle(color: Colors.white)),

                      Text("Bulan: $bulan",
                          style: const TextStyle(color: Colors.white)),

                      Text("Hari: $hari",
                          style: const TextStyle(color: Colors.white)),

                      Text("Jam: $jam",
                          style: const TextStyle(color: Colors.white)),

                      Text("Menit: $menit",
                          style: const TextStyle(color: Colors.white)),

                      Text("Detik: $detik",
                          style: const TextStyle(color: Colors.white)),

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