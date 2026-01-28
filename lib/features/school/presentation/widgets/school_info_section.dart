import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/school/presentation/widgets/school_section_label.dart';
import 'package:gaia/features/school/presentation/widgets/school_info_box.dart';

class SchoolInfoSection extends StatelessWidget {
  final String label;
  final String value;

  const SchoolInfoSection({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SchoolSectionLabel(label: label),
        SizedBox(height: 8.h),
        SchoolInfoBox(value: value),
      ],
    );
  }
}
