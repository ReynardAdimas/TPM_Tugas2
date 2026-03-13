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
    '1','2','3','DEL', 
    'C','0', '.','='
  ]; 

  // method 
  void pressedButton(String buttonText) {
    setState(() {
      if(buttonText == 'C')
      {
        _result = '0';
      } 
      else if(buttonText == 'DEL') {
        if (_result == 'Error') {
          _result = '0';
        } else if (_result.length > 1) {
          _result = _result.substring(0, _result.length-1);
        } else {
          _result = '0';
        }
      }
      else if(buttonText == '.') {
        if(_result == 'Error') {
          _result = '0.'; 
          return; 
        } 

        String lastNumber = _result.split(RegExp(r'[+-]')).last; 

        if(lastNumber.contains('.')) {
          return;
        } 

        if(_result.endsWith('+') || _result.endsWith('-')) {
          _result += '0.';
        } else {
          _result += '.';
        }
      }
      else if(buttonText == '=') 
      {
        try {
          String temp = _result.replaceAll('-', '+-'); 
          List<String> parts = temp.split('+'); 
          double total = 0; 
          for (String part in parts) {
            if(part.isNotEmpty) {
              total += double.parse(part);
            }
          }

          if (total == total.toInt()) {
            _result = total.toInt().toString();
          } else {
            _result = total.toString();
          }
        } catch (e) {
          _result = 'Error';
        }
      }
      else 
      {
        if (buttonText == '+' || buttonText == '-') {
          if(_result == '0' && buttonText == '+') {
            return;
          }
          if(_result.endsWith('+') || _result.endsWith('-')) {
            _result = _result.substring(0, _result.length-1)+buttonText;
            return;
          }
          _result += buttonText;
        }
        else {
          if (buttonText == '0') {
            if(_result == '0' || _result.endsWith('+0') || _result.endsWith('-0')) {
              return;
            }
          }
          else {
            if (_result == '0') {
              _result = buttonText;
              return;
            } 
            else if( _result.endsWith('+0') || _result.endsWith('-0')) {
              _result = _result.substring(0, _result.length-1) + buttonText; 
              return;
            }
          }

          if(_result == 'Error') {
            _result = buttonText;
          } else {
            _result += buttonText;
          }
        }
      }
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Penjumlah dan Pengurangan"),
        centerTitle: true,
        backgroundColor: Colors.grey[400],
      ),
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
                crossAxisCount: 4, 
                crossAxisSpacing: 8.0, 
                mainAxisSpacing: 8.0
              ), 
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: (){
                    pressedButton(buttons[index]);
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (buttons[index] == 'C' || buttons[index] == '=' || buttons[index] == 'DEL') ? Colors.orange : Colors.white,
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