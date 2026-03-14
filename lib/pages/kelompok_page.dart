import 'package:flutter/material.dart';

class KelompokPage extends StatelessWidget {
  const KelompokPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
              "Data Kelompok",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      backgroundColor: Colors.black,

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// HEADER
            

            const SizedBox(height: 15),

            /// KOTAK DATA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Table(
                border: TableBorder.all(color: Colors.white),

                children: const [
                  /// HEADER TABEL
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Nama",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "NIM",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// DATA 1
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Andhika Kusuma Wardana",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "123230041",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  /// DATA 2
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Muhammad Dira Raharja",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "123230052",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  /// DATA 3
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Reynard Adimas Nabil",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "123230079",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  /// DATA 2
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Bagoes Lanang Cahya Manoenggal",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "123230231",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
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
