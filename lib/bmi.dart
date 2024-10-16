
import 'package:flutter/material.dart';

class BmiApp extends StatefulWidget {
  const BmiApp({super.key});

  @override
  State<BmiApp> createState() => _BmiAppState();
}

class _BmiAppState extends State<BmiApp> {

  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  String result = "";
  String bmiStage = "";
  bool clicked = false;

  void _calculateBMI() {

    if (_height.text.isEmpty || _weight.text.isEmpty) {
      setState(() {
        result = "Please enter both weight and height!";
        bmiStage = "";
      });

      return;
    }

    double height = double.parse(_height.text) / 100;
    double weight = double.parse(_weight.text);

    if (height < 1 || weight < 1) {
      setState(() {
        result = "Weight and height must be grater than 0.";
        bmiStage = "";
      });
      return;
    }

    double bmi = weight/(height * height);
      setState(() {
        result = bmi.toStringAsFixed(2);
        bmiStage = bmiResultStage(bmi);
        clicked = true;
      }
    );
  } 


  String bmiResultStage(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "Normal weight";
    } else if (bmi >= 25.0 && bmi < 29.9) {
      return "Overweight";
    } else {
      return "Obesity";
    }
  }

  void dipose() {
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,   
                children: [

                  const Text("Calculate Your BMI",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(height: 20.0,),

                  TextField(
                    maxLength: 3,
                    controller: _weight,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.line_weight),
                      prefixIconColor: Colors.deepPurpleAccent,
                      label: Text("Enter Weight (kg): "),
                      border: OutlineInputBorder()
                    ),
                  ),

                  const SizedBox(height: 10.0,),

                  TextField(
                    maxLength: 3,
                    controller: _height,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.height),
                      prefixIconColor: Colors.deepPurpleAccent,
                      label: Text("Enter Height (cm): "),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10.0,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _calculateBMI,
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.deepPurple)
                      ), 
                      child: const Text("Calculate BMI",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        ),


        Expanded(
          child: Column(
            children: [
              Text(
                clicked ? "Your BMI : $result" : "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                clicked ? "You are $bmiStage." : "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

