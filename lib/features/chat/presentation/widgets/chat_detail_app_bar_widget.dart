import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:icarus/features/chat/domain/entity/chat_contact_entity.dart';

class ChatDetailAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final ChatContactEntity? contact;

  const ChatDetailAppBarWidget({
    super.key,
    this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: _buildUserInfo(context),
        titleSpacing: 0,
      ),
    );
  }

  Widget _buildUserInfo(
    BuildContext context,
  ) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16.r,
          backgroundImage:
              contact?.photo != null ? NetworkImage(contact!.photo!) : null,
          child: contact?.photo == null
              ? Icon(Icons.person, size: 16.r, color: Colors.grey)
              : null,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                contact?.name ?? '-',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (contact?.className != null && contact!.className!.isNotEmpty)
                Text(
                  contact!.className!,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    color: context.brand.inactive,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
