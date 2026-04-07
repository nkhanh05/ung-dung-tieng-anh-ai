import 'package:flutter/material.dart';
import '../constants.dart';

class MultipleChoicePage extends StatefulWidget {
  final bool isMixed;
  const MultipleChoicePage({super.key, this.isMixed = false});

  @override
  State<MultipleChoicePage> createState() => _MultipleChoicePageState();
}

class _MultipleChoicePageState extends State<MultipleChoicePage> {
  int _index = 0;
  final List<Map<String, dynamic>> _data = [
    {"q": "Apple", "img": Icons.apple, "options": ["Apple", "Banana", "Orange"], "ans": "Apple"},
    {"q": "Car", "img": Icons.directions_car, "options": ["Bike", "Car", "Bus"], "ans": "Car"},
  ];

  void _check(String choice) {
    if (choice == _data[_index]['ans']) {
      if (_index < _data.length - 1) {
        setState(() => _index++);
      } else {
        _showDone();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sai rồi! Thử lại nhé."), backgroundColor: Colors.red));
    }
  }

  void _showDone() {
    showDialog(context: context, builder: (c) => AlertDialog(title: const Text("Hoàn thành!"), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Đóng"))]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: colorTeal, title: const Text("Trắc nghiệm")),
      body: Container(
        width: double.infinity, decoration: backgroundDecoration,
        child: Column(children: [
          const SizedBox(height: 40),
          Icon(_data[_index]['img'], size: 100, color: Colors.red),
          IconButton(icon: const Icon(Icons.volume_up, size: 40, color: colorOrange), onPressed: () {}),
          const SizedBox(height: 30),
          ...(_data[_index]['options'] as List).map((opt) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: colorGreen, minimumSize: const Size(double.infinity, 55)),
              onPressed: () => _check(opt),
              child: Text(opt, style: const TextStyle(color: Colors.white, fontSize: 18)),
            ),
          )),
        ]),
      ),
    );
  }
}