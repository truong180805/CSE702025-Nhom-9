import 'package:flutter/material.dart';

class TodayTasksScreen extends StatelessWidget {
  final List<Task> tasks = [
    Task(title: 'Design Login Page', time: '9:00 AM - 10:00 AM'),
    Task(title: 'Team Meeting', time: '11:00 AM - 12:00 PM'),
    Task(title: 'Code Review', time: '2:00 PM - 3:00 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today Task',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.more_vert),
                ],
              ),
              SizedBox(height: 20),

              // Task List
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskCard(task: task);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Task model
class Task {
  final String title;
  final String time;

  Task({required this.title, required this.time});
}

// Task Card widget
class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Checkbox(value: false, onChanged: (value) {}),
        title: Text(task.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(task.time),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
