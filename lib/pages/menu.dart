import 'package:flutter/material.dart';
import 'package:tpm_tugas2/pages/bilangan_page.dart';
import 'package:tpm_tugas2/pages/jumlah_kurang.dart';
import 'package:tpm_tugas2/pages/jumlah_total_angka_page.dart';
import 'package:tpm_tugas2/pages/kelompok_page.dart';
import 'package:tpm_tugas2/pages/login_page.dart';
import 'package:tpm_tugas2/pages/piramid_page.dart';
import 'package:tpm_tugas2/pages/stopwatch_screen.dart';
import 'package:tpm_tugas2/pages/umur_page.dart';
import 'package:tpm_tugas2/pages/weton.dart';

class Menu extends StatefulWidget {
  final String username;
  const Menu({super.key, required this.username});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> { 
  final List<String> menus = ['Data Kelompok', 'Penjumlahan dan Pengurangan Angka', 'Cek paritas dan prima bilangan', 'Stopwatch', 'Kalkulator Piramid', 'Jumlah Total Angka', 'Cek Umur', 'Cek Hari'];

  void pilihMenu(int index) {
    if(menus[index] == 'Data Kelompok') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => KelompokPage()));
    } 
    else if (menus[index] == 'Penjumlahan dan Pengurangan Angka') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => JumlahKurang()));
    } else if (menus[index] == 'Cek paritas dan prima bilangan') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BilanganPage()));
    } else if (menus[index] == 'Stopwatch') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => StopwatchScreen()));
    } else if (menus[index] == 'Jumlah Total Angka') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => JumlahTotalAngkaPage()));
    }
    else if (menus[index] == 'Cek Umur') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => UmurPage()));
    }
    else if (menus[index] == 'Cek Hari') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => WetonConverterScreen()));
    }
    else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PiramidPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: Text("Welcome, ${widget.username}", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(
                  builder: (context) => LoginPage(),
                  ), 
                  (Route<dynamic> route) => false, 
                );
            }, 
            icon: Icon(Icons.logout, color: Colors.white,)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            const SizedBox(height: 24.0,), 
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 2.0), 
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Column(
                  children: [
                    // Text("Welcome, ${widget.username}", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
                    const Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22.0, 
                        fontWeight: FontWeight.bold
                      ), 
                    ), 
                    const SizedBox(height: 24.0,), 
                    Expanded(
                      child: ListView.builder(
                        itemCount: menus.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0), 
                            child: InkWell(
                              onTap: () {
                                pilihMenu(index);
                              },
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white70, width: 2.0), 
                                  borderRadius: BorderRadius.circular(16.0)
                                ),
                                child: Center(
                                  child: Text(
                                    menus[index], 
                                    style: const TextStyle(
                                      color: Colors.white, 
                                      fontSize: 18.0
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      )
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}