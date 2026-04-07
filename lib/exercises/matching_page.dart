import 'package:flutter/material.dart';
import '../constants.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({super.key});
  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  String? selectedImg;
  String? selectedWord;
  Map<String, String> pairs = {"Apple": "🍎", "Banana": "🍌", "Car": "🚗"};
  List<String> matched = [];

  void _check() {
    if (selectedImg != null && selectedWord != null) {
      if (pairs[selectedWord] == selectedImg) {
        setState(() {
          matched.add(selectedWord!);
          selectedImg = null; selectedWord = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Không khớp!"), duration: Duration(milliseconds: 500)));
        setState(() { selectedImg = null; selectedWord = null; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: colorTeal, title: const Text("Nối hình ảnh")),
      body: Row(
        children: [
          // Cột Ảnh
          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: pairs.values.map((e) => _item(e, true)).toList())),
          // Cột Chữ
          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: pairs.keys.map((e) => _item(e, false)).toList())),
        ],
      ),
    );
  }

  Widget _item(String val, bool isImg) {
    bool isSelected = (isImg ? selectedImg == val : selectedWord == val);
    bool isDone = isImg ? matched.contains(pairs.keys.firstWhere((k) => pairs[k] == val)) : matched.contains(val);

    return GestureDetector(
      onTap: isDone ? null : () {
        setState(() { isImg ? selectedImg = val : selectedWord = val; });
        _check();
      },
      child: Container(
        width: 100, height: 100,
        decoration: BoxDecoration(
          color: isDone ? Colors.green : (isSelected ? colorOrange : colorGreen),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: Text(val, style: TextStyle(fontSize: isImg ? 40 : 18, color: Colors.white))),
      ),
    );
  }
}