import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Để định dạng ngày và giờ
import 'package:task_manager_app/models/task.dart'; // Import Task model từ vị trí mới

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedProjectGroup;
  DateTime? _selectedStartDate;
  TimeOfDay? _selectedStartTime;
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedEndTime;

  final List<String> _projectGroups = [
    'Office project',
    'Personal project',
    'Daily study'
  ];

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _selectedStartDate = pickedDate;
          // Đảm bảo ngày kết thúc không trước ngày bắt đầu
          if (_selectedEndDate != null && _selectedEndDate!.isBefore(pickedDate)) {
            _selectedEndDate = pickedDate;
          }
        } else {
          _selectedEndDate = pickedDate;
          // Đảm bảo ngày bắt đầu không sau ngày kết thúc
          if (_selectedStartDate != null && _selectedStartDate!.isAfter(pickedDate)) {
            _selectedStartDate = pickedDate;
          }
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStart) {
          _selectedStartTime = pickedTime;
        } else {
          _selectedEndTime = pickedTime;
        }
      });
    }
  }

  void _saveProject() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedProjectGroup == null ||
        _selectedStartDate == null ||
        _selectedStartTime == null ||
        _selectedEndDate == null ||
        _selectedEndTime == null) {
      // Hiển thị thông báo lỗi nếu có trường bị thiếu
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin.')),
      );
      return;
    }

    final newTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      projectGroup: _selectedProjectGroup!,
      startDate: _selectedStartDate!,
      startTime: _selectedStartTime!,
      endDate: _selectedEndDate!,
      endTime: _selectedEndTime!,
    );

    Navigator.pop(context, newTask); // Trả về công việc mới
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm Công Việc Mới'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white, // Đặt màu chữ cho tiêu đề AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Tiêu đề công việc", style: TextStyle(fontSize: 16)),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Nhập tiêu đề công việc',
                ),
              ),
              const SizedBox(height: 16),
              const Text("Mô tả", style: TextStyle(fontSize: 16)),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Nhập mô tả công việc',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Nhóm công việc", style: TextStyle(fontSize: 16)),
              DropdownButtonFormField<String>(
                value: _selectedProjectGroup,
                hint: const Text('Chọn nhóm'),
                items: _projectGroups.map((String group) {
                  return DropdownMenuItem<String>(
                    value: group,
                    child: Text(group),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedProjectGroup = newValue;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Ngày bắt đầu", style: TextStyle(fontSize: 16)),
              GestureDetector(
                onTap: () => _selectDate(context, true),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                      text: _selectedStartDate == null
                          ? ''
                          : DateFormat('dd/MM/yyyy').format(_selectedStartDate!),
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Chọn ngày bắt đầu',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Thời gian bắt đầu", style: TextStyle(fontSize: 16)),
              GestureDetector(
                onTap: () => _selectTime(context, true),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                      text: _selectedStartTime == null
                          ? ''
                          : _selectedStartTime!.format(context),
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Chọn thời gian bắt đầu',
                      suffixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Ngày kết thúc", style: TextStyle(fontSize: 16)),
              GestureDetector(
                onTap: () => _selectDate(context, false),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                      text: _selectedEndDate == null
                          ? ''
                          : DateFormat('dd/MM/yyyy').format(_selectedEndDate!),
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Chọn ngày kết thúc',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Thời gian kết thúc", style: TextStyle(fontSize: 16)),
              GestureDetector(
                onTap: () => _selectTime(context, false),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                      text: _selectedEndTime == null
                          ? ''
                          : _selectedEndTime!.format(context),
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Chọn thời gian kết thúc',
                      suffixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProject,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Lưu Công Việc"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}