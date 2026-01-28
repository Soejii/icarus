import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatDateSeparatorWidget extends StatelessWidget {
  final dynamic date; 

  const ChatDateSeparatorWidget({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    
    DateTime messageDate;
    if (date is DateTime) {
      messageDate = DateTime(date.year, date.month, date.day);
    } else {
      try {
        final parsedDate = DateTime.parse(date.toString());
        messageDate = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
      } catch (e) {
        messageDate = today;
      }
    }

    String dateText;
    if (_isSameDay(messageDate, today)) {
      dateText = 'Hari ini';
    } else if (_isSameDay(messageDate, yesterday)) {
      dateText = 'Kemarin';
    } else {
      final displayDate = date is DateTime ? date : DateTime.parse(date.toString());
      dateText = DateFormat('dd MMMM yyyy', 'id_ID').format(displayDate);
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            dateText,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }
}
