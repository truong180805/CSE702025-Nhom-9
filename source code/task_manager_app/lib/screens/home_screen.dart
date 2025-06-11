// IMPORT
import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task.dart'; // Import Task model
import 'today_tasks_screen.dart'; // Import TodayTasksScreen
import 'user_screen.dart'; // Import UserScreen
import 'add_project_screen.dart'; // Import AddProjectScreen
// import 'dart:io'; // Đã loại bỏ dòng này vì không còn sử dụng File cho ảnh đại diện

// MÀN HOME VỚI NAVIGATION
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Thông tin người dùng toàn cục
  String _userName = 'Người Dùng';
  String _userEmail = 'user@example.com';
  DateTime? _userDOB; // Thêm ngày sinh
  // String? _userProfileImagePath; // Đã loại bỏ đường dẫn ảnh đại diện

  // Danh sách công việc toàn cầu (tạm thời)
  List<Task> _allTasks = [
    Task(
      title: 'Design Login Page',
      description: 'Thiết kế giao diện người dùng cho trang đăng nhập.',
      projectGroup: 'Office project',
      startDate: DateTime.now(),
      startTime: TimeOfDay(hour: 9, minute: 0),
      endDate: DateTime.now(),
      endTime: TimeOfDay(hour: 10, minute: 0),
      isCompleted: false,
    ),
    Task(
      title: 'Team Meeting',
      description: 'Cuộc họp nhóm để thảo luận tiến độ dự án.',
      projectGroup: 'Office project',
      startDate: DateTime.now(),
      startTime: TimeOfDay(hour: 11, minute: 0),
      endDate: DateTime.now(),
      endTime: TimeOfDay(hour: 12, minute: 0),
      isCompleted: true,
    ),
    Task(
      title: 'Code Review',
      description: 'Xem lại mã nguồn cho module mới.',
      projectGroup: 'Personal project',
      startDate: DateTime.now().add(Duration(days: 1)),
      startTime: TimeOfDay(hour: 14, minute: 0),
      endDate: DateTime.now().add(Duration(days: 1)),
      endTime: TimeOfDay(hour: 15, minute: 0),
      isCompleted: false,
    ),
    Task(
      title: 'Project Planning',
      description: 'Lập kế hoạch cho dự án mới.',
      projectGroup: 'Office project',
      startDate: DateTime.now().subtract(Duration(days: 1)),
      startTime: TimeOfDay(hour: 10, minute: 0),
      endDate: DateTime.now().subtract(Duration(days: 1)),
      endTime: TimeOfDay(hour: 11, minute: 30),
      isCompleted: false,
    ),
    Task(
      title: 'Client Call',
      description: 'Gọi điện cho khách hàng để cập nhật tiến độ.',
      projectGroup: 'Office project',
      startDate: DateTime.now().add(Duration(days: 1)),
      startTime: TimeOfDay(hour: 16, minute: 0),
      endDate: DateTime.now().add(Duration(days: 1)),
      endTime: TimeOfDay(hour: 16, minute: 30),
      isCompleted: false,
    ),
    Task(
      title: 'Làm bài tập Flutter',
      description: 'Hoàn thành bài tập về UI Flutter.',
      projectGroup: 'Daily study',
      startDate: DateTime.now(),
      startTime: TimeOfDay(hour: 19, minute: 0),
      endDate: DateTime.now(),
      endTime: TimeOfDay(hour: 21, minute: 0),
      isCompleted: false,
    ),
    Task(
      title: 'Đọc sách lập trình',
      description: 'Đọc chương 5 của cuốn sách Clean Code.',
      projectGroup: 'Daily study',
      startDate: DateTime.now(),
      startTime: TimeOfDay(hour: 21, minute: 0),
      endDate: DateTime.now(),
      endTime: TimeOfDay(hour: 22, minute: 0),
      isCompleted: true,
    ),
  ];

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _initializeScreens(); // Khởi tạo màn hình trong một hàm riêng
  }

  // Hàm để khởi tạo hoặc cập nhật danh sách màn hình
  void _initializeScreens() {
    _screens = [
      HomeContent(
        userName: _userName, // Truyền tên người dùng
        // userProfileImagePath: _userProfileImagePath, // Đã loại bỏ truyền ảnh đại diện
        allTasks: _allTasks,
        onViewTasks: _navigateToTodayTasks,
        onViewGroupTasks: _navigateToTodayTasksWithGroup,
      ),
      TodayTasksScreen(
        allTasks: _allTasks,
        onTasksUpdated: _updateTasks,
      ),
      // Truyền thông tin người dùng và callback vào UserScreen
      UserScreen(
        currentUserName: _userName,
        currentUserEmail: _userEmail,
        currentUserDOB: _userDOB,
        // currentProfileImagePath: _userProfileImagePath, // Đã loại bỏ truyền ảnh đại diện
        onUpdateUser: _updateUserInfo,
      ),
    ];
  }

  void _updateTasks(List<Task> updatedTasks) {
    setState(() {
      _allTasks = updatedTasks;
      _initializeScreens(); // Cập nhật lại các màn hình sau khi tasks thay đổi
    });
  }

  // Hàm callback để cập nhật thông tin người dùng từ UserScreen
  void _updateUserInfo(String name, String email, DateTime? dob) { // Đã loại bỏ String? profileImagePath
    setState(() {
      _userName = name;
      _userEmail = email;
      _userDOB = dob;
      // _userProfileImagePath = profileImagePath; // Đã loại bỏ cập nhật ảnh đại diện
      _initializeScreens(); // Khởi tạo lại màn hình để cập nhật UI
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToTodayTasks() {
    setState(() {
      _selectedIndex = 1; // Chuyển sang màn hình Today Tasks
      _screens[1] = TodayTasksScreen(
        allTasks: _allTasks,
        onTasksUpdated: _updateTasks,
        initialFocusedDay: DateTime.now(),
        initialFilterGroup: null,
      );
    });
  }

  void _navigateToTodayTasksWithGroup(String groupName) {
    setState(() {
      _selectedIndex = 1; // Chuyển sang màn hình Today Tasks
      _screens[1] = TodayTasksScreen(
        allTasks: _allTasks,
        onTasksUpdated: _updateTasks,
        initialFocusedDay: DateTime.now(),
        initialFilterGroup: groupName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButton: Transform.translate(
        offset: Offset(0, -30),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF3F51B5),
          elevation: 6,
          child: Icon(Icons.add, size: 32),
          onPressed: () async {
            final newTask = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProjectScreen()),
            );
            if (newTask != null && newTask is Task) {
              setState(() {
                _allTasks.add(newTask);
                _updateTasks(_allTasks);
                _selectedIndex = 1;
              });
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFF7C4DFF),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Today Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    );
  }
}

// NỘI DUNG TRANG CHỦ
class HomeContent extends StatelessWidget {
  final String userName; // Nhận tên người dùng
  // final String? userProfileImagePath; // Đã loại bỏ nhận đường dẫn ảnh đại diện
  final List<Task> allTasks;
  final VoidCallback onViewTasks;
  final Function(String) onViewGroupTasks;

  const HomeContent({
    required this.userName, // Thêm required cho userName
    // this.userProfileImagePath, // Đã loại bỏ userProfileImagePath
    required this.allTasks,
    required this.onViewTasks,
    required this.onViewGroupTasks,
  });

  @override
  Widget build(BuildContext context) {
    // Tính toán tiến độ
    final today = DateTime.now();
    final todayTasks = allTasks.where((task) =>
        task.startDate.year == today.year &&
        task.startDate.month == today.month &&
        task.startDate.day == today.day).toList();
    final completedTodayTasks = todayTasks.where((task) => task.isCompleted).length;
    final totalTodayTasks = todayTasks.length;

    // Tính toán số task cho từng nhóm
    Map<String, int> taskCountsByGroup = {};
    for (var task in allTasks) {
      taskCountsByGroup.update(task.projectGroup, (value) => value + 1, ifAbsent: () => 1);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            // HEADER - CHÀO MỪNG (Đã loại bỏ AVATAR)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Xin Chào!',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    Text(
                      userName, // Hiển thị tên người dùng từ biến
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // Đã loại bỏ CircleAvatar
              ],
            ),
            SizedBox(height: 24),

            // TIẾN ĐỘ THỰC HIỆN
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF7C4DFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tiến độ thực hiện',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '$completedTodayTasks/$totalTodayTasks Nhiệm vụ đã hoàn thành',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: onViewTasks, // Gọi callback khi nhấn nút
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF7C4DFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Xem nhiệm vụ'),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: totalTodayTasks == 0 ? 0 : completedTodayTasks / totalTodayTasks,
                          backgroundColor: Colors.white24,
                          color: Colors.white,
                          strokeWidth: 6,
                        ),
                      ),
                      Text(
                        totalTodayTasks == 0 ? "0%" : "${(completedTodayTasks / totalTodayTasks * 100).toInt()}%",
                        style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // TASK GROUPS
            Text("Task Groups",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            TaskGroupCard(
              title: 'Office project',
              tasks: '${taskCountsByGroup['Office project'] ?? 0} task',
              onTap: () => onViewGroupTasks('Office project'),
            ),
            TaskGroupCard(
              title: 'Personal project',
              tasks: '${taskCountsByGroup['Personal project'] ?? 0} task',
              onTap: () => onViewGroupTasks('Personal project'),
            ),
            TaskGroupCard(
              title: 'Daily study',
              tasks: '${taskCountsByGroup['Daily study'] ?? 0} task',
              onTap: () => onViewGroupTasks('Daily study'),
            ),
          ],
        ),
      ),
    );
  }
}

// THẺ NHÓM TASK
class TaskGroupCard extends StatelessWidget {
  final String title;
  final String tasks;
  final VoidCallback onTap; // Thêm onTap callback

  const TaskGroupCard({
    required this.title,
    required this.tasks,
    required this.onTap, // Yêu cầu onTap
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(Icons.folder, color: Colors.grey),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(tasks),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap, // Gọi onTap khi nhấn vào
      ),
    );
  }
}