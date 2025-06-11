import 'package:flutter/material.dart';

// Định nghĩa Task object duy nhất
class Task {
  final String title;
  final String description; // Thêm trường mô tả
  final String projectGroup; // Thêm trường nhóm dự án
  final DateTime startDate; // Thêm ngày bắt đầu
  final TimeOfDay startTime; // Thêm giờ bắt đầu
  final DateTime endDate; // Thêm ngày kết thúc
  final TimeOfDay endTime; // Thêm giờ kết thúc
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.projectGroup,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    this.isCompleted = false,
  });
}