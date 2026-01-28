import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/school/domain/entities/school_entity.dart';
import 'package:gaia/features/school/presentation/widgets/school_profile_avatar.dart';
import 'package:gaia/features/school/presentation/widgets/school_info_section.dart';

class SchoolInformationContent extends StatelessWidget {
  final SchoolEntity school;

  const SchoolInformationContent({
    super.key,
    required this.school,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 49.h),
          SchoolProfileAvatar(photoUrl: school.photo),
          SizedBox(height: 37.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SchoolInfoSection(
                  label: 'Nama Sekolah',
                  value: school.name,
                ),
                SizedBox(height: 16.h),
                SchoolInfoSection(
                  label: 'Nomor Induk / NPSN',
                  value: school.registrationNumber,
                ),
                SizedBox(height: 16.h),
                SchoolInfoSection(
                  label: 'Akreditasi',
                  value: school.accreditation,
                ),
                SizedBox(height: 16.h),
                SchoolInfoSection(
                  label: 'Alamat Sekolah',
                  value: school.address,
                ),
                SizedBox(height: 16.h),
                SchoolInfoSection(
                  label: 'Telepon',
                  value: school.phone,
                ),
                SizedBox(height: 16.h),
                SchoolInfoSection(
                  label: 'Email',
                  value: school.email,
                ),
                SizedBox(height: 16.h),
                SchoolInfoSection(
                  label: 'Website',
                  value: school.website,
                ),
                SizedBox(height: 16.h),
                SchoolInfoSection(
                  label: 'Instagram',
                  value: school.instagram,
                ),
                 SizedBox(height: 16.h),
                SchoolInfoSection(
                  label: 'Facebook',
                  value: school.facebook,
                ),
                                 SizedBox(height: 16.h),
                 SchoolInfoSection(
                  label: 'Youtube',
                  value: school.youtube,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
