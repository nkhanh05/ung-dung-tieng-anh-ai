import 'dart:convert';
import 'package:http/http.dart' as http;

class SQLService {
  // Vì là app Desktop chạy cùng máy với Node.js nên dùng localhost
  static const String apiUrl = "http://localhost:3000/query";

  // Hàm phụ trách việc gửi câu lệnh SQL sang Node.js
  static Future<List<dynamic>> executeQuery(String sql) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'query': sql,
      }), // Đúng với cái req.body.query bên Node.js
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Lỗi SQL: ${response.body}");
    }
  }

  // HÀM CHÍNH: Tách truy vấn
  static Future<void> addWord(
    String term,
    String definition,
    String userID,
    String? photoUrl,
  ) async {
    try {
      final cleanTerm = term.toLowerCase().trim();
      final cleanDef = definition.toLowerCase().trim();
      final sqlPhotoUrl = (photoUrl == null || photoUrl.isEmpty)
          ? "NULL"
          : "'$photoUrl'";

      // 1. Kiểm tra từ đã có trong bảng Word chưa
      String checkWordQuery =
          "SELECT wordID FROM Word WHERE term = '$cleanTerm'";
      var wordResult = await executeQuery(checkWordQuery);

      String wordID;
      if (wordResult.isEmpty) {
        // Nếu chưa có thì thêm mới vào bảng Word
        // Lưu ý: Dùng N'$cleanDef' để không bị lỗi tiếng Việt
        await executeQuery(
          "INSERT INTO Word (term, definition) VALUES ('$cleanTerm', N'$cleanDef')",
        );

        // Lấy lại wordID vừa tạo
        var newWordResult = await executeQuery(checkWordQuery);
        wordID = newWordResult[0]['wordID'].toString();
      } else {
        wordID = wordResult[0]['wordID'].toString();
      }

      // 2. Kiểm tra xem User đã có từ này trong kho (Word_User) chưa
      String checkOwnership =
          "SELECT 1 FROM User_Word WHERE userID = '$userID' AND wordID = '$wordID'";
      var ownershipResult = await executeQuery(checkOwnership);

      if (ownershipResult.isEmpty) {
        // Nếu chưa có thì mới INSERT vào bảng Word_User
        String insertWordUser =
            """
          INSERT INTO User_Word (userID, wordID, PhotoUrl) 
          VALUES ('$userID', '$wordID', $sqlPhotoUrl)
        """;
        await executeQuery(insertWordUser);
        print("--- [DONE] Lưu từ vựng vào kho thành công ---");
      } else {
        print("--- [INFO] Từ này đã có trong kho cá nhân rồi ---");
      }
    } catch (e) {
      print("--- [ERROR] Có lo rồi: $e ---");
    }
  }
}
