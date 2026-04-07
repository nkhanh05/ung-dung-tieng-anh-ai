import 'package:flutter/material.dart';
import 'constants.dart';
import 'word_detail_page.dart';
import 'my_library_page.dart';
import 'exercise_menu_page.dart';
import 'settings_page.dart';
import 'leaderboard_page.dart'; // Import thêm trang bảng xếp hạng

class ScanObjectPage extends StatefulWidget {
  const ScanObjectPage({super.key});

  @override
  State<ScanObjectPage> createState() => _ScanObjectPageState();
}

class _ScanObjectPageState extends State<ScanObjectPage> {
  // Key để điều khiển Sidebar (Drawer)
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // --- 1. HEADER (APPBAR) ---
      appBar: AppBar(
        backgroundColor: colorTeal,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: const [
            Icon(Icons.local_fire_department, color: Colors.orange, size: 28),
            SizedBox(width: 5),
            Text("5", style: TextStyle(color: Colors.white, fontSize: 18)),
            Spacer(),
            Icon(Icons.notifications, color: colorOrange, size: 30),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: colorOrange, size: 35),
            onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
          ),
        ],
      ),

      // --- 2. SIDEBAR (DRAWER BÊN PHẢI) ---
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.2, // Độ rộng hẹp 20%
        backgroundColor: colorGreen.withOpacity(0.95),
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Biểu tượng Tìm kiếm (Chưa code trang này)
            const _SidebarIcon(icon: Icons.search),
            
            // Nút sang Thư viện (Quyển sách)
            _buildSidebarButton(
              icon: Icons.menu_book, 
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const MyLibraryPage()))
            ),

            // Nút sang Bài tập (Cây bút)
            _buildSidebarButton(
              icon: Icons.edit, 
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const ExerciseMenuPage()))
            ),

            // Nút sang Bảng xếp hạng (Chiếc cúp)
            _buildSidebarButton(
              icon: Icons.emoji_events, // Biểu tượng chiếc cúp
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const LeaderboardPage()))
            ),

            // Nút sang Cài đặt (Bánh răng)
            _buildSidebarButton(
              icon: Icons.settings, 
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const SettingsPage()))
            ),
          ],
        ),
      ),

      // --- 3. NỘI DUNG CHÍNH ---
      body: Container(
        width: double.infinity,
        decoration: backgroundDecoration,
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // KHU VỰC CAMERA & BOUNDING BOX
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Stack(
                  children: [
                    // Giả lập khung hình Camera
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=500'), 
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    
                    // BOUNDING BOX (Vùng nhận diện có thể nhấn)
                    Positioned(
                      top: 100,
                      left: 50,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WordDetailPage(word: "Apple")),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                "Apple >",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // NÚT HƯỚNG DẪN DƯỚI CÙNG
            _buildBottomInstruction(),
          ],
        ),
      ),
    );
  }

  // Hàm hỗ trợ tạo nút trong Sidebar để tránh lặp code và đảm bảo Drawer tự đóng khi nhấn
  Widget _buildSidebarButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Đóng Drawer trước
        onTap(); // Thực hiện chuyển trang
      },
      child: _SidebarIcon(icon: icon),
    );
  }

  Widget _buildBottomInstruction() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: colorOrange,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          "GIỮ THIẾT BỊ VÀ NHẤN VÀO TỪ VỰNG HIỂN THỊ",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }
}

// Widget phụ cho các biểu tượng Sidebar
class _SidebarIcon extends StatelessWidget {
  final IconData icon;
  const _SidebarIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Icon(icon, size: 35, color: Colors.black54),
    );
  }
}