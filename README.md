# ai_english_application

Hướng dẫn chạy demo:
- Chỉ cần chạy file main là chạy được tất cả demo.
- AE cần chỉnh trang nào thì chỉ cần chỉnh trang đó, không cần động vào file main
- Cần phải setup môi trường flutter qua trang chủ: https://docs.flutter.dev/install/quick
- Tải cả file về, lưu ý giữ nguyên phần asset chứa background và file pubspec.yaml để tránh xung đột
Hướng dẫn kết nối với cơ sở dữ liệu:
- Flutter không thể kết nối trực tiếp với hệ quản trị cơ sở dữ liệu mà cần trung gian, tôi sẽ dùng node.js cho anh em mình dễ hiểu
- Trong file sqlConnectivity.dart là các hàm mình sẽ gọi để truy vấn tới cơ sở dữ liệu thông qua node.js, các hàm truy vấn mình sẽ để ở đây để tiện quản lí còn nếu cần dùng thì import vào là được
- Trong quá trình cần đảm bảo cơ sở dữ liệu được mở trước sau đó mở server rồi mới chạy demo
- Cần tạo thêm một Login có khả năng đọc, thêm , xóa các thông tin trong database của mình, cần cho phép mở cổng TCP/IP
- Thay đổi đường dẫn tới hệ quản trị thông qua file server.js
  
