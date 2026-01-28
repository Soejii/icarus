import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/chat/domain/type/chat_role_type.dart';

class ChatContactTabBar extends StatelessWidget {
  final ChatRole selectedRole;
  final ValueChanged<ChatRole> onRoleChanged;

  const ChatContactTabBar({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final roles = [ChatRole.student, ChatRole.teacher];

    return Container(
      height: 56.h,
      width: double.infinity,
      decoration:  BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.shadow,
      ),
      child: Row(
        children: roles.map((role) {
          final isSelected = selectedRole == role;

          return Expanded(
            child: GestureDetector(
              onTap: () => onRoleChanged(role),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 28.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: isSelected ? context.brand.primary : Colors.white,
                    border: Border.all(
                      width: 1.w,
                      color: isSelected
                          ? Colors.transparent
                          : context.brand.primary,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    child: Center(
                      child: Text(
                        role.label,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : context.brand.inactive,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
