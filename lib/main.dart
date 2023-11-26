import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = '0';
  String _currentNumber = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operand = '';

  void _onNumberClick(String text) {
    setState(() {
      if (text == '.') {
        if (!_currentNumber.contains('.')) {
          _currentNumber += text;
        }
      } else {
        _currentNumber += text;
      }
      _output = _currentNumber;
    });
  }

  void _onOperandClick(String text) {
    setState(() {
      _operand = text;
      _num1 = double.parse(_currentNumber);
      _currentNumber = '';
    });
  }

  void _onEqualsClick() {
    setState(() {
      _num2 = double.parse(_currentNumber);

      switch (_operand) {
        case '+':
          _output = (_num1 + _num2).toString();
          break;
        case '-':
          _output = (_num1 - _num2).toString();
          break;
        case '*':
          _output = (_num1 * _num2).toString();
          break;
        case '/':
          _output = (_num1 / _num2).toString();
          break;
        default:
          _output = 'Error';
      }

      _currentNumber = _output;
      _operand = '';
    });
  }

  void _onClearClick() {
    setState(() {
      _output = '0';
      _currentNumber = '';
      _num1 = 0;
      _num2 = 0;
      _operand = '';
    });
  }

  Widget _buildButton(String text, {Color color = Colors.white}) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          if (text == 'C') {
            _onClearClick();
          } else if (text == '=') {
            _onEqualsClick();
          } else if (text == '+' || text == '-' || text == '*' || text == '/') {
            _onOperandClick(text);
          } else {
            _onNumberClick(text);
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Divider(height: 0.0),
          Row(
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/', color: Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*', color: Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-', color: Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('C'),
              _buildButton('0'),
              _buildButton('.', color: Colors.white),
              _buildButton('+', color: Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('=', color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
