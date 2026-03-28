import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class KonversiTanggalPage extends StatefulWidget {
  @override
  _KonversiTanggalPageState createState() => _KonversiTanggalPageState();
}

class _KonversiTanggalPageState extends State<KonversiTanggalPage> {
  TextEditingController tanggalController = TextEditingController();
  String hasilMasehi = "";
  String hasilHijriah = "";

  @override
  void initState() {
    super.initState();
    // Atur bahasa kalender Hijriah ke bahasa lokal (opsional)
  }

  // Fungsi untuk memunculkan DatePicker
  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black, 
              onPrimary: Colors.white, 
              onSurface: Colors.black, 
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, 
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      try {
        // Format Masehi
        String masehiFormat = DateFormat('dd MMMM yyyy').format(picked);
        
        // Konversi ke Hijriah
        var tanggalHijriah = HijriCalendar.fromDate(picked);
        String hijriahFormat =
            "${tanggalHijriah.hDay} ${tanggalHijriah.longMonthName} ${tanggalHijriah.hYear} H";

        // Tampilkan Hasil
        setState(() {
          tanggalController.text = masehiFormat; 
          hasilMasehi = masehiFormat;
          hasilHijriah = hijriahFormat;
        });
        
      } catch (e) {
        // Tangkap error jika package bermasalah
        setState(() {
          hasilMasehi = "Gagal memproses";
          hasilHijriah = "Error: $e"; // Menampilkan error di kotak hitam
        });
        print("Error detail: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
      appBar: AppBar(
        title: const Text(
          "Konversi Tanggal",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // TextField diklik untuk buka kalender
            TextField(
              controller: tanggalController,
              readOnly: true, // Biar ga bisa diketik manual
              onTap: () => _pilihTanggal(context),
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                labelText: "Pilih Tanggal Masehi",
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.calendar_month, color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            
            const SizedBox(height: 30),

            // Menampilkan Hasil Konversi
            if (hasilHijriah.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black, // Box hasil warna hitam senada dengan tombol
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Tanggal Masehi:",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      hasilMasehi,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Bertepatan dengan:",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      hasilHijriah,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}