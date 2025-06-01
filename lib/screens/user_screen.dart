import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Avatar & Tên
              SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              SizedBox(height: 10),
              Text(
                'Nguyen Truong',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('User ID: #123456', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 30),

              // Các tùy chọn
              UserOption(icon: Icons.person, label: 'Personal Info', onTap: () {}),
              UserOption(icon: Icons.settings, label: 'Settings', onTap: () {}),
              UserOption(icon: Icons.help_outline, label: 'Help & Support', onTap: () {}),
              UserOption(icon: Icons.logout, label: 'Logout', onTap: () {
                // Ví dụ chuyển về màn hình đầu
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class UserOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const UserOption({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF7C4DFF)),
        title: Text(label),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
