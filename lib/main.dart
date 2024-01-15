import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  double num1 = 0;
  double num2 = 0;
  String operand = '';

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _clear();
    } else if (buttonText == '+' || buttonText == '-' || buttonText == '×' || buttonText == '÷') {
      _selectOperation(buttonText);
    } else if (buttonText == '=') {
      _calculate();
    } else {
      _appendNumber(buttonText);
    }
  }

  void _clear() {
    setState(() {
      _output = '0';
      num1 = 0;
      num2 = 0;
      operand = '';
    });
  }

  void _selectOperation(String selectedOperand) {
    setState(() {
      num1 = double.parse(_output);
      operand = selectedOperand;
      _output = '0';
    });
  }

  void _appendNumber(String digit) {
    setState(() {
      if (_output == '0') {
        _output = digit;
      } else {
        _output += digit;
      }
    });
  }

  void _calculate() {
    setState(() {
      num2 = double.parse(_output);
      switch (operand) {
        case '+':
          _output = (num1 + num2).toString();
          break;
        case '-':
          _output = (num1 - num2).toString();
          break;
        case '×':
          _output = (num1 * num2).toString();
          break;
        case '÷':
          if (num2 != 0) {
            _output = (num1 / num2).toString();
          } else {
            _output = 'Error';
          }
          break;
        default:
          _output = 'Error';
      }
      operand = '';
      num1 = double.parse(_output);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('MY Calculator')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: 16,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _buttonPressed(_buttonText(index));
                  },
                  child: Container(
                    color: _buttonColor(index),
                    child: Center(
                      child: Text(
                        _buttonText(index),
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _buttonText(int index) {
    final buttonTexts = [
      '7', '8', '9', '÷',
      '4', '5', '6', '×',
      '1', '2', '3', '-',
      'C', '0', '=', '+',
    ];
    return buttonTexts[index];
  }

  Color _buttonColor(int index) {
    final buttonText = _buttonText(index);

    if (buttonText == '÷' || buttonText == '×' || buttonText == '-' || buttonText == '+' || buttonText == '=') {
      return Colors.orange;
    } else if (buttonText == 'C') {
      return Colors.red;
    } else {
      return Colors.grey[300] ?? Colors.black; // Set a default color in case grey[300] is null.
    }
  }
}