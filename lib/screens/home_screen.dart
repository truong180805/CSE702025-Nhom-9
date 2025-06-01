// IMPORT
import 'package:flutter/material.dart';
import 'today_tasks_screen.dart'; // tạo sau
import 'user_screen.dart';        // tạo sau
import 'add_project_screen.dart';

// MÀN HOME VỚI NAVIGATION
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeContent(),
    TodayTasksScreen(),
    UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProjectScreen()),
          );
        },
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: Color.fromARGB(255, 186, 178, 209),
      selectedItemColor: Color(0xFF3F51B5),
      unselectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    ),
  );
}


}

// PHẦN NỘI DUNG CHÍNH HOME
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER: Avatar + Tên + Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                      radius: 24,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello !', style: TextStyle(color: Colors.grey)),
                        Text('Nguyen Truong',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.notifications_none_outlined),
              ],
            ),
            SizedBox(height: 24),

            // TIẾN ĐỘ HÔM NAY
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF7C4DFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("your today's task",
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 4),
                        Text("almost done",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('view task'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Color(0xFF7C4DFF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          value: 0.7,
                          backgroundColor: Colors.white24,
                          color: Colors.white,
                          strokeWidth: 6,
                        ),
                      ),
                      Text("70%", style: TextStyle(color: Colors.white)),
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
            TaskGroupCard(title: 'Office project', tasks: '7 task'),
            TaskGroupCard(title: 'Personal project', tasks: '5 task'),
            TaskGroupCard(title: 'Daily study', tasks: '3 task'),
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

  const TaskGroupCard({required this.title, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(Icons.folder, color: Colors.grey),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(tasks),
        onTap: () {},
      ),
    );
  }
}
