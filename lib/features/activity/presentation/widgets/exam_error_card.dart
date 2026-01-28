import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/shared/core/types/failure.dart';

class ExamErrorCard extends StatelessWidget {
  const ExamErrorCard({
    super.key,
    required this.error,
    required this.onRetry,
  });
  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final msg = error is Failure
        ? error.runtimeType.toString()
        : 'Terjadi Kesalahan';
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(msg),
          SizedBox(height: 8.h),
          ElevatedButton(onPressed: onRetry, child: const Text('Coba Lagi!')),
        ],
      ),
    );
  }
}
