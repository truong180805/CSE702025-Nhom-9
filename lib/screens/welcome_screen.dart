import 'package:flutter/material.dart';
import 'home_screen.dart'; // Sẽ tạo sau khi hoàn thành welcome

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Màu nền sáng
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ảnh minh họa ở giữa
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.asset(
                  'assets/images/welcome.png', // cần có ảnh trong assets
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Tiêu đề
            Text(
              'Task Management &\nTo-Do List',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            // Mô tả ngắn
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'This productive tool is designed to help you better manage your task project-wise conveniently!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ),

            SizedBox(height: 32),

            // Nút "Let's Start"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7C4DFF),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Let's Start", style: TextStyle(fontSize: 16 , color: Colors.white,)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward , color: Colors.white, size: 24,),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
