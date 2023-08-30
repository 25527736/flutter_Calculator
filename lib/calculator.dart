import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// const blackColor = Color(0xff040D12);
const operatorColor = Color(0xFF183D3D);
const buttonColor = Color(0xff5C5470);
const redColor = Colors.red;
const greenColor = Colors.green;

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

var input = '';
var output = '';
var operation = '';
var hideInput = false;
var outputSize = 25.0;
class _CalculatorState extends State<Calculator> {
  onButtonClick(value) {
    if (value == 'C') {
      input = '';
      output = '';
    } else if (value == '<--') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if(output.endsWith(".0")){
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput =true;
        outputSize = 38;
      }
    } else {
      input += value;
      hideInput =false;
      outputSize = 25;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff040D12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF183D3D),
        title: const Center(
          child: Text('Calculator'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(25),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: const TextStyle(color: Colors.white, fontSize: 48),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    output,
                    style: TextStyle(color: Colors.white, fontSize: outputSize),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button(text: 'C', tgColor: redColor),
              button(text: '<--', tgColor: greenColor),
              button(text: '%', tgColor: greenColor),
              button(text: '/', tgColor: greenColor),
            ],
          ),
          Row(
            children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: '*', tgColor: greenColor),
            ],
          ),
          Row(
            children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '-', tgColor: greenColor),
            ],
          ),
          Row(
            children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+', tgColor: greenColor),
            ],
          ),
          Row(
            children: [
              button(text: '', buttonBackgroundColor: Colors.transparent),
              button(text: '0'),
              button(text: '.'),
              button(text: '=', tgColor: greenColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget button(
      {text, buttonBackgroundColor = buttonColor, tgColor = Colors.white}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(9),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(22),
            backgroundColor: buttonBackgroundColor,
          ),
          onPressed: () {
            onButtonClick(text);
          },
          child: Text(
            text,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: tgColor),
          ),
        ),
      ),
    );
  }
}
