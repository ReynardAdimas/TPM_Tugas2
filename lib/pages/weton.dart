import 'package:flutter/material.dart';

class WetonConverterScreen extends StatefulWidget {
  const WetonConverterScreen({Key? key}) : super(key: key);

  @override
  State<WetonConverterScreen> createState() => _WetonConverterScreenState();
}

class _WetonConverterScreenState extends State<WetonConverterScreen> {
  final TextEditingController _tanggalController = TextEditingController(text: '15');
  final TextEditingController _bulanController = TextEditingController(text: 'Maret');
  final TextEditingController _tahunController = TextEditingController(text: '2025');

  String _hari = '';
  String _weton = '';

  final DateTime _anchorDate = DateTime.utc(1970, 1, 1);
  final List<String> _hariList = ['Kamis', 'Jumat', 'Sabtu', 'Minggu', 'Senin', 'Selasa', 'Rabu'];
  final List<String> _pasaranList = ['Wage', 'Kliwon', 'Legi', 'Pahing', 'Pon'];

  final Map<String, int> _bulanMap = {
    'januari': 1, 'februari': 2, 'maret': 3, 'april': 4,
    'mei': 5, 'juni': 6, 'juli': 7, 'agustus': 8,
    'september': 9, 'oktober': 10, 'november': 11, 'desember': 12,
  };

  @override
  void initState() {
    super.initState();
    _tanggalController.addListener(_hitungWeton);
    _bulanController.addListener(_hitungWeton);
    _tahunController.addListener(_hitungWeton);
    
    // Hitung di awal untuk mengisi hasil konversi
    _hitungWeton();
  }

  @override
  void dispose() {
    _tanggalController.dispose();
    _bulanController.dispose();
    _tahunController.dispose();
    super.dispose();
  }

  void _hitungWeton() {
    int? tanggal = int.tryParse(_tanggalController.text);
    int? tahun = int.tryParse(_tahunController.text);
    int? bulan;

    // Parsing Bulan (bisa berupa angka "3" atau teks "Maret")
    String bulanText = _bulanController.text.toLowerCase().trim();
    if (int.tryParse(bulanText) != null) {
      bulan = int.parse(bulanText);
    } else {
      bulan = _bulanMap[bulanText];
    }

    // Validasi input
    if (tanggal != null && bulan != null && tahun != null &&
        bulan >= 1 && bulan <= 12 && tanggal >= 1 && tanggal <= 31) {
      try {
        DateTime inputDate = DateTime.utc(tahun, bulan, tanggal);

        // Pastikan tanggal valid (contoh: bukan 30 Februari)
        if (inputDate.year == tahun && inputDate.month == bulan && inputDate.day == tanggal) {
          int diffDays = inputDate.difference(_anchorDate).inDays;

          // Perhitungan modulus dengan penanganan nilai negatif
          int hariIndex = (diffDays % 7 + 7) % 7;
          int pasaranIndex = (diffDays % 5 + 5) % 5;

          setState(() {
            _hari = _hariList[hariIndex];
            _weton = _pasaranList[pasaranIndex];
          });
        } else {
          setState(() { _hari = ''; _weton = ''; });
        }
      } catch (e) {
        setState(() { _hari = ''; _weton = ''; });
      }
    } else {
      setState(() { _hari = ''; _weton = ''; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
         backgroundColor: const Color(0xFF121212),
         title: Text(
          'Cek Weton', 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 26, 
            fontWeight: FontWeight.w500
          ),
         ),
         iconTheme: IconThemeData(
          color: Colors.white
         ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   'Konversi Tanggal',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 26,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // const SizedBox(height: 40),
              
              // Baris Input Form
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildInputField('Tanggal', _tanggalController, isNumber: true),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 4,
                    child: _buildInputField('Bulan', _bulanController, isNumber: false),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 4,
                    child: _buildInputField('Tahun', _tahunController, isNumber: true),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // Bagian Output Hari
              const Center(
                child: Text(
                  'Hari',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 12),
              _buildResultBox(_hari),
              const SizedBox(height: 32),

              // Bagian Output Weton
              const Center(
                child: Text(
                  'Weton',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 12),
              _buildResultBox(_weton),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Reusable untuk TextField
  Widget _buildInputField(String label, TextEditingController controller, {required bool isNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.black, fontSize: 16),
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  // Widget Reusable untuk Box Hasil (Hari & Weton)
  Widget _buildResultBox(String value) {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}