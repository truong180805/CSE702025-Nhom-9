# TO-DO LIST APP

## Giới Thiệu

"TO-DO LIST APP" là một ứng dụng Java sử dụng giao diện Swing nhằm hỗ trợ người dùng quản lý công việc hàng ngày.

### Mục Tiêu

Ứng dụng này được phát triển với mục tiêu:
- Giúp người dùng tăng hiệu suất cá nhân, quản lý thời gian tốt hơn.

## Tính Năng

- **Đăng Nhập**: 
  - Người dùng cần đăng nhập với tài khoản hợp lệ để truy cập vào các chức năng của ứng dụng.
  
- **Quản Lý Công Việc**: 
  - Tạo, sửa, xoá công việc
  -	Gắn nhãn, đặt thời gian, ưu tiên
  -	Tự động nhắc nhở công việc

## Công Nghệ Sử Dụng

- **Java**: Ngôn ngữ lập trình chính cho ứng dụng.
- **Java Swing**: Thư viện GUI được sử dụng để xây dựng giao diện người dùng.
- **Maven**: Công cụ quản lý dự án và thư viện, nếu cần thiết.

## Cài Đặt

### Bước 1: Cài Đặt JDK

- Tải và cài đặt Java Development Kit (JDK) từ trang chính thức của Oracle: [Download JDK](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)

### Bước 2: Clone Repository

- Sử dụng Git để clone repository về máy tính của bạn:
   ```bash
   git clone <repository-url>
### Bước 3: Mở Dự Án

- Mở IDE mà bạn ưa thích (IntelliJ IDEA, Eclipse, NetBeans, v.v.) và nhập dự án đã clone.

### Bước 4: Chạy Ứng Dụng
- Chạy file App.java để khởi động ứng dụng.

### Hướng Dẫn Sử Dụng
* Đăng Nhập:
- Khi ứng dụng khởi động, một cửa sổ đăng nhập sẽ xuất hiện. Nhập thông tin tài khoản:
- Tài khoản: admin
- Mật khẩu: password
- Nhấn nút "Đăng nhập". Nếu thông tin đúng, bạn sẽ được chuyển đến giao diện chính.

* Thêm task
- Khi vào giao diện chính thì có các chức năng "Thêm","Sửa","Xóa","Lưu".
- Người dùng sẽ phải nhập thông tin task cần nhập xong nhấn nút "Thêm" để thêm vào lịch.
- Nút "Clear" dùng để xóa thông tin bên phải mà không làm ảnh hưởng đến lịch.

* Tìm kiém theo Ngày/Tháng/Năm:
- Người dùng nhấn nút Ngày/Tháng/Năm rồi nhập thông tin và nhấn nút "Tìm kiếm" là có thể hiện thông tin mà trùng khớp thông tin vừa nhập.
- Nút "Tắt" để thoát khỏi màn hình Tìm kiếm theo Ngày/Tháng/Năm.
