import 'package:flutter/material.dart';
import 'package:tpm_tugas2/pages/menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordHidden = true;
  final TextEditingController _usernameController = TextEditingController(); 
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void login() {
      String usn = _usernameController.text; 
      String pwd = _passwordController.text; 

      if(usn == "subagus" && pwd == "kriptogaasik") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu(username: usn)));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login Berhasil"),
            backgroundColor: Colors.green,
            )
        );
      } else {
        if(usn == "" && pwd == "") {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Username dan Password Harap Diisi"),
            backgroundColor: Colors.red,
            )
        );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Username atau Password Salah"),
            backgroundColor: Colors.red,
            )
        ); 
        _usernameController.clear(); 
        _passwordController.clear();
        }
      }
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),),
            SizedBox(height: 100,),
            TextField(
              cursorColor: Colors.black,
              controller: _usernameController,
              decoration: InputDecoration(
                label: Text("Masukkan Username", style: TextStyle(color: Colors.black),), 
                fillColor: Colors.black, 
                hoverColor: Colors.black, 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ), 
                
              ),
            ), 
            SizedBox(height: 10,), 
            TextField(
              cursorColor: Colors.black,
              controller: _passwordController,
              obscureText: isPasswordHidden,
              decoration: InputDecoration(
                label: Text("Masukkan Password", style: TextStyle(color: Colors.black),), 
                fillColor: Colors.black,
                hoverColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  }, 
                  icon: Icon(
                    isPasswordHidden ? Icons.visibility_off : Icons.visibility
                  )
                )
              ),
            ), 
            SizedBox(height: 30,), 
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  login();
                }, 
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.black)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}