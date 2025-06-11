// import 'dart:io'; // Đã loại bỏ vì không còn sử dụng File
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // Đã loại bỏ import thư viện image_picker
import 'package:intl/intl.dart'; // Thêm để định dạng ngày

class UserScreen extends StatefulWidget {
  final String currentUserName;
  final String currentUserEmail;
  final DateTime? currentUserDOB; // Ngày sinh hiện tại
  // final String? currentProfileImagePath; // Đã loại bỏ đường dẫn ảnh đại diện hiện tại

  // Callback để gửi dữ liệu người dùng đã cập nhật về HomeScreen
  final Function(String name, String email, DateTime? dob) onUpdateUser; // Đã loại bỏ String? profileImagePath

  const UserScreen({
    Key? key,
    required this.currentUserName,
    required this.currentUserEmail,
    this.currentUserDOB,
    // this.currentProfileImagePath, // Đã loại bỏ
    required this.onUpdateUser,
  }) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // File? _profileImage; // Đã loại bỏ biến này
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _dobController; // Controller cho ngày sinh
  DateTime? _selectedDOB; // Biến để lưu trữ ngày sinh

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentUserName);
    _emailController = TextEditingController(text: widget.currentUserEmail);
    _selectedDOB = widget.currentUserDOB;
    _dobController = TextEditingController(
      text: _selectedDOB == null ? '' : DateFormat('dd/MM/yyyy').format(_selectedDOB!),
    );
    // if (widget.currentProfileImagePath != null) {
    //   _profileImage = File(widget.currentProfileImagePath!);
    // }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDOB ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDOB) {
      setState(() {
        _selectedDOB = pickedDate;
        _dobController.text = DateFormat('dd/MM/yyyy').format(_selectedDOB!);
      });
    }
  }

  void _saveUserInfo() {
    // Gọi callback để cập nhật thông tin người dùng trong HomeScreen
    widget.onUpdateUser(
      _nameController.text,
      _emailController.text,
      _selectedDOB,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Thông tin đã được cập nhật!')),
    );
    // XÓA BỎ DÒNG NÀY: Navigator.of(context).pop();
    // Lý do: UserScreen là một tab của BottomNavigationBar, không phải một route được push lên.
    // Việc gọi pop() sẽ cố gắng pop HomeScreen (hoặc màn hình trước đó nếu có) ra khỏi stack, gây màn hình đen.
    // Dữ liệu đã được truyền về HomeScreen qua callback onUpdateUser, và HomeScreen sẽ tự động cập nhật UI.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ảnh đại diện (hiện tại là placeholder)
            // Stack(
            //   alignment: Alignment.center,
            //   children: [
            // CircleAvatar(
            //   radius: 60,
            //   backgroundColor: Colors.grey[200],
            //   backgroundImage: _profileImage != null
            //       ? FileImage(_profileImage!)
            //       : const AssetImage('assets/images/user_placeholder.png') as ImageProvider,
            // ),
            //   Positioned(
            //     bottom: 0,
            //     right: 0,
            //     child: GestureDetector(
            //       onTap: _pickImage,
            //       child: Container(
            //         padding: const EdgeInsets.all(8),
            //         decoration: const BoxDecoration(
            //           color: Colors.deepPurple,
            //           shape: BoxShape.circle,
            //         ),
            //         child: const Icon(
            //           Icons.camera_alt,
            //           color: Colors.white,
            //           size: 20,
            //         ),
            //       ),
            //     ),
            //   ),
            // ],
            // ),
            const SizedBox(height: 24),
            // Trường Tên
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Tên người dùng',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            // Trường Email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            // Trường Ngày sinh
            GestureDetector(
              onTap: () => _selectDateOfBirth(context),
              child: AbsorbPointer( // Ngăn bàn phím hiện ra khi nhấn vào TextField
                child: TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(
                    labelText: 'Ngày sinh',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.cake),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Nút "Lưu Thay Đổi"
            SizedBox(
              width: double.infinity, // Nút chiếm toàn bộ chiều rộng
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3F51B5), // Màu nền của nút
                  foregroundColor: Colors.white,   // Màu chữ và icon trên nút
                  padding: EdgeInsets.symmetric(vertical: 16), // Khoảng đệm bên trong nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bo tròn góc nút
                  ),
                ),
                onPressed: _saveUserInfo, // Gọi hàm lưu thông tin
                child: Text('Lưu Thay Đổi', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}