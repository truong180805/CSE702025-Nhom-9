// today_tasks_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // Thêm vào để định dạng thời gian và ngày
import 'package:task_manager_app/models/task.dart'; // Import Task model

class TodayTasksScreen extends StatefulWidget {
  final List<Task> allTasks; // Nhận danh sách công việc từ HomeScreen
  final Function(List<Task>) onTasksUpdated; // Callback để cập nhật lại danh sách công việc
  final DateTime? initialFocusedDay; // Ngày ban đầu được focus
  final String? initialFilterGroup; // Nhóm ban đầu để lọc

  TodayTasksScreen({
    required this.allTasks,
    required this.onTasksUpdated,
    this.initialFocusedDay,
    this.initialFilterGroup,
  });

  @override
  _TodayTasksScreenState createState() => _TodayTasksScreenState();
}

class _TodayTasksScreenState extends State<TodayTasksScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  List<Task> _currentTasks = []; // Danh sách công việc cục bộ để hiển thị

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialFocusedDay ?? DateTime.now();
    _selectedDay = _focusedDay;
    _currentTasks = List.from(widget.allTasks); // Khởi tạo với tất cả tasks
  }

  // Cập nhật _currentTasks khi widget.allTasks thay đổi
  @override
  void didUpdateWidget(covariant TodayTasksScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.allTasks != oldWidget.allTasks) {
      _currentTasks = List.from(widget.allTasks);
    }
  }


  List<Task> _getTasksForDay(DateTime day) {
    // Lọc theo ngày
    final tasksOnSelectedDay = _currentTasks.where((task) =>
        task.startDate.year == day.year &&
        task.startDate.month == day.month &&
        task.startDate.day == day.day).toList();

    // Lọc thêm theo nhóm nếu có initialFilterGroup
    if (widget.initialFilterGroup != null) {
      return tasksOnSelectedDay.where((task) =>
          task.projectGroup == widget.initialFilterGroup).toList();
    }
    return tasksOnSelectedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      // Tìm công việc trong danh sách gốc (_allTasks) và cập nhật trạng thái
      final index = widget.allTasks.indexOf(task);
      if (index != -1) {
        widget.allTasks[index].isCompleted = !widget.allTasks[index].isCompleted;
        // Gọi callback để thông báo cho HomeScreen về sự thay đổi
        widget.onTasksUpdated(widget.allTasks);
      }
    });
  }

  void _deleteTask(Task taskToDelete) {
    setState(() {
      // Xóa công việc khỏi danh sách _allTasks
      widget.allTasks.remove(taskToDelete);
      // Cập nhật lại danh sách _currentTasks để UI được refresh
      _currentTasks = List.from(widget.allTasks);
      // Gọi callback để thông báo cho HomeScreen về sự thay đổi
      widget.onTasksUpdated(widget.allTasks);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã xóa công việc: ${taskToDelete.title}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Lấy tasks cho ngày được chọn và áp dụng filter nhóm nếu có
    final tasksForSelectedDay = _getTasksForDay(_selectedDay!);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lịch Công Việc',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TableCalendar<Task>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              eventLoader: _getTasksForDay, // eventLoader chỉ dùng để hiển thị marker
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                markersAnchor: 0.0, // Đảm bảo marker hiển thị đúng vị trí
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _selectedDay != null
                    ? "Công việc ngày: ${DateFormat('dd/MM/yyyy').format(_selectedDay!)}"
                    : "Chọn một ngày",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: tasksForSelectedDay.isEmpty
                  ? Center(
                      child: Text(
                        "Không có công việc nào cho ngày này.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      itemCount: tasksForSelectedDay.length,
                      itemBuilder: (context, index) {
                        final task = tasksForSelectedDay[index];
                        return TaskCard(
                          task: task,
                          onCompletedToggle: () => _toggleTaskCompletion(task),
                          onDelete: () => _deleteTask(task), // Truyền hàm xóa
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Cập nhật TaskCard
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onCompletedToggle;
  final VoidCallback onDelete; // Thêm callback xóa

  const TaskCard({
    required this.task,
    required this.onCompletedToggle,
    required this.onDelete, // Yêu cầu onDelete
  });

  @override
  Widget build(BuildContext context) {
    // Định dạng thời gian cho hiển thị
    final String formattedTime =
        '${task.startTime.format(context)} - ${task.endTime.format(context)}';

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (bool? value) {
            onCompletedToggle();
          },
          activeColor: Colors.deepPurple,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: task.isCompleted ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formattedTime), // Hiển thị thời gian bắt đầu và kết thúc
            Text('Nhóm: ${task.projectGroup}', style: TextStyle(fontSize: 12, color: Colors.blueGrey)), // Hiển thị nhóm
          ],
        ),
        trailing: IconButton( // Thêm IconButton cho chức năng xóa
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text('Xác nhận xóa'),
                  content: Text('Bạn có chắc chắn muốn xóa công việc "${task.title}" không?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Hủy'),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Xóa'),
                      onPressed: () {
                        onDelete(); // Gọi callback xóa khi xác nhận
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        onTap: () {
          // Khi nhấn vào task card, hiển thị dialog chi tiết
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text(task.title, style: TextStyle(fontWeight: FontWeight.bold)),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Mô tả: ${task.description}'),
                      SizedBox(height: 8),
                      Text('Nhóm: ${task.projectGroup}'),
                      SizedBox(height: 8),
                      Text('Bắt đầu: ${DateFormat('dd/MM/yyyy').format(task.startDate)} lúc ${task.startTime.format(context)}'),
                      SizedBox(height: 8),
                      Text('Kết thúc: ${DateFormat('dd/MM/yyyy').format(task.endDate)} lúc ${task.endTime.format(context)}'),
                      SizedBox(height: 8),
                      Text('Trạng thái: ${task.isCompleted ? 'Đã hoàn thành' : 'Chưa hoàn thành'}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Đóng'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}