import 'package:flutter/material.dart';

void main() => runApp(BMIApp());

class BMIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: BMI(),
    );
  }
}

class BMI extends StatefulWidget {
  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmiResult = 0;
  String resultText = '';
  String interpretation = '';

  void calculate() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;

    if (weight <= 0 || height <= 0) {
      setState(() {
        bmiResult = 0;
        resultText = 'Invalid Input';
        interpretation = 'Please enter valid values for weight and height.';
      });
      return;
    }

    double bmi = weight / ((height / 100) * (height / 100));
    setState(() {
      bmiResult = bmi;

      if (bmi < 18.5) {
        resultText = 'Underweight';
        interpretation = 'Kamu terlalu kurus,makanlah yang banyak.';
      } else if (bmi >= 18.5 && bmi < 24.9) {
        resultText = 'Normal';
        interpretation = 'Kamu memiliki tinggi dan berat badan yang ideal,PERTAHANKAN!';
      } else if (bmi >= 25 && bmi < 29.9) {
        resultText = 'Overweight';
        interpretation = 'Kamu sedikit gemuk,Cobalah diet';
      } else {
        resultText = 'Obese';
        interpretation = 'Kamu Obesitas,Cepat Periksakan ke Dokter';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Weight (Kg)';
                        }
                        return null;
                      },
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Weight",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Height (cm)';
                        }
                        return null;
                      },
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Height",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          calculate();
                        }
                      },
                      child: Text('Calculate BMI'),
                    ),
                    SizedBox(height: 16.0),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.pinkAccent),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'BMI Result: $bmiResult\nCategory: $resultText\nInterpretation: $interpretation',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
