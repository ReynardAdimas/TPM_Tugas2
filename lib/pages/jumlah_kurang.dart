import 'package:flutter/material.dart';

class JumlahKurang extends StatefulWidget {
  const JumlahKurang({super.key});

  @override
  State<JumlahKurang> createState() => _JumlahKurangState();
}

class _JumlahKurangState extends State<JumlahKurang> {
  String _result = '0'; 

  final List<String> buttons = [
    '7', '8', '9', '+', 
    '4','5','6', '-',
    '1','2','3','=', 
    'C','0'
  ]; 

  // method 
  void pressedButton(String buttonText) {
    setState(() {
      if(buttonText == 'C')
      {
        _result = '0';
      } 
      else if(buttonText == '=') 
      {

      }
      else 
      {
        if(_result == '0') 
        {
          _result = buttonText;
        }
        else 
        {
          _result += buttonText;
        }
      }
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(32.0),
              child: Text(
                _result.toString(), 
                style: TextStyle(fontSize: 60),
              ),
            )
          ), 
          Expanded(
            flex:2, 
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4
              ), 
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: (){
                    pressedButton(buttons[index]);
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (buttons[index] == 'C' || buttons[index] == '=') ? Colors.orange : Colors.white,
                    foregroundColor: Colors.black
                  ),
                  child: Text(
                    buttons[index], 
                    style: TextStyle(fontSize: 28),
                  )
                );
              }
            ), 
          )
        ],
      ),
    );
  }
}