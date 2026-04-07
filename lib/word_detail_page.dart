import 'package:flutter/material.dart';
import 'constants.dart';

class WordDetailPage extends StatelessWidget {
  final String word;
  const WordDetailPage({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(context),
      body: Container(
        width: double.infinity,
        decoration: backgroundDecoration,
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text("Thông tin của từ", style: TextStyle(fontSize: 28, color: Colors.black87)),
            const SizedBox(height: 20),
            
            // Hàng biểu tượng danh mục
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryIcon(Icons.font_download, "TỪ"),
                _buildCategoryIcon(Icons.menu_book, "ĐỊNH NGHĨA"),
                _buildCategoryIcon(Icons.volume_up, "PHÁT ÂM"),
                _buildCategoryIcon(Icons.image, "HÌNH ẢNH"),
              ],
            ),
            
            // Khung nội dung chính
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(25),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: colorGreen, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Dữ liệu của từ '$word'\n(Định nghĩa & Hình ảnh)",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),

            // Các nút bấm phía dưới
            _buildActionButtons(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildHeader(BuildContext context) {
    return AppBar(
      backgroundColor: colorTeal,
      elevation: 0,
      title: Row(
        children: const [
          Icon(Icons.local_fire_department, color: Colors.orange),
          SizedBox(width: 5),
          Text("5", style: TextStyle(color: Colors.white)),
          Spacer(),
          Icon(Icons.notifications, color: colorOrange),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: colorGreen, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        _bottomButton("Lưu từ vào thư viện của tôi", colorOrange, () {}),
        const SizedBox(height: 15),
        _bottomButton("Loại bỏ và quét vật thể mới", colorOrange, () => Navigator.pop(context)),
      ],
    );
  }

  Widget _bottomButton(String text, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}