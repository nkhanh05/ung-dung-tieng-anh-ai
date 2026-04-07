import 'package:flutter/material.dart';
import 'constants.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 3 lựa chọn: Bạn bè, Khu vực, Thế giới
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorTeal,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: const [
              Icon(Icons.local_fire_department, color: Colors.orange),
              SizedBox(width: 5),
              Text("5", style: TextStyle(color: Colors.white, fontSize: 18)),
              Spacer(),
              Icon(Icons.notifications, color: colorOrange),
            ],
          ),
          // --- THANH TAB LỰA CHỌN ---
          bottom: const TabBar(
            indicatorColor: colorOrange,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Bạn bè"),
              Tab(text: "Khu vực"),
              Tab(text: "Thế giới"),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: backgroundDecoration,
          child: TabBarView(
            children: [
              _buildRankingList("Friends"), // Danh sách bạn bè
              _buildRankingList("Region"),  // Danh sách khu vực
              _buildRankingList("World"),   // Danh sách thế giới
            ],
          ),
        ),
      ),
    );
  }

  // Widget xây dựng danh sách xếp hạng
  Widget _buildRankingList(String type) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 10, // Giả lập 10 người đứng đầu
      itemBuilder: (context, index) {
        bool isTop3 = index < 3;
        int rank = index + 1;

        // --- CẤU HÌNH HUY CHƯƠNG CHO TOP 3 ---
        Widget leadingWidget;
        if (index == 0) {
          // Vị trí số 1: Huy chương vàng
          leadingWidget = const Icon(Icons.workspace_premium, color: Colors.amber, size: 40);
        } else if (index == 1) {
          // Vị trí số 2: Huy chương bạc
          leadingWidget = Icon(Icons.workspace_premium, color: Colors.grey[400], size: 35);
        } else if (index == 2) {
          // Vị trí số 3: Huy chương đồng
          leadingWidget = Icon(Icons.workspace_premium, color: Colors.brown[300], size: 30);
        } else {
          // Các vị trí còn lại: Số thứ tự bình thường
          leadingWidget = SizedBox(
            width: 40,
            child: Text(
              "$rank",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            // Top 3 dùng màu nền nổi bật hơn (nền cam đậm)
            color: isTop3 ? colorOrange.withOpacity(0.9) : colorGreen,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // Hiển thị huy chương hoặc số thứ tự
              leadingWidget,
              const SizedBox(width: 20),
              // Ảnh đại diện giả lập
              const CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 15),
              // Tên người dùng
              Expanded(
                child: Text(
                  index == 0 ? "You (Admin)" : "User $rank",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              // Điểm số/Streak
              Row(
                children: [
                  const Text(
                    "1250", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(width: 5),
                  // Biểu tượng điểm (sao cho thứ hạng thấp, cúp cho thứ hạng cao)
                  Icon(
                    index < 3 ? Icons.stars : Icons.star, 
                    color: Colors.yellow, 
                    size: 20
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}