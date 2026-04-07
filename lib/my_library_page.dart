import 'package:flutter/material.dart';
import 'constants.dart';

class MyLibraryPage extends StatelessWidget {
  const MyLibraryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: colorTeal, leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))),
      body: Container(
        width: double.infinity, decoration: backgroundDecoration,
        child: Column(children: [
          const SizedBox(height: 20),
          const Text("THƯ VIỆN CỦA TÔI", style: TextStyle(fontSize: 44, color: Color(0xFF800000), fontWeight: FontWeight.bold)),
          Align(alignment: Alignment.centerRight, child: Padding(padding: const EdgeInsets.only(right: 25), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: colorOrange, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.filter_alt, color: Colors.white)))),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_icon(Icons.font_download), _icon(Icons.menu_book), _icon(Icons.volume_up), _icon(Icons.image)]),
          Expanded(child: ListView.builder(padding: const EdgeInsets.all(20), itemCount: 5, itemBuilder: (c, i) => Container(height: 70, margin: const EdgeInsets.only(bottom: 10), decoration: BoxDecoration(color: colorGreen, borderRadius: BorderRadius.circular(15))))),
        ]),
      ),
    );
  }
  Widget _icon(IconData icon) => Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: colorGreen, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: Colors.white));
}