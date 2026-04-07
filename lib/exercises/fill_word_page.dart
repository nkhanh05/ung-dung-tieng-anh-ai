import 'package:flutter/material.dart';
import '../constants.dart';

class FillWordPage extends StatefulWidget {
  const FillWordPage({super.key});
  @override
  State<FillWordPage> createState() => _FillWordPageState();
}

class _FillWordPageState extends State<FillWordPage> {
  final TextEditingController _ctrl = TextEditingController();
  String _ans = "Apple";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: colorTeal, title: const Text("Điền từ")),
      body: Container(
        width: double.infinity, decoration: backgroundDecoration,
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          const Icon(Icons.apple, size: 120, color: Colors.red),
          const SizedBox(height: 20),
          TextField(
            controller: _ctrl,
            decoration: InputDecoration(filled: true, fillColor: colorBeige, hintText: "Nhập từ tiếng Anh...", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_ctrl.text.toLowerCase().trim() == _ans.toLowerCase()) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Chính xác!"), backgroundColor: Colors.green));
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: colorOrange, minimumSize: const Size(200, 55)),
            child: const Text("XÁC NHẬN", style: TextStyle(color: Colors.white)),
          )
        ]),
      ),
    );
  }
}