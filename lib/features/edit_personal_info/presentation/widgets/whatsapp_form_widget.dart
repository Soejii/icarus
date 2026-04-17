import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_form_field_widget.dart';

class WhatsappFormWidget extends ConsumerStatefulWidget {
  const WhatsappFormWidget({super.key});

  @override
  ConsumerState<WhatsappFormWidget> createState() => _WhatsappFormWidgetState();
}

class _WhatsappFormWidgetState extends ConsumerState<WhatsappFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _wa1Controller;
  late final TextEditingController _wa2Controller;

  @override
  void initState() {
    super.initState();
    _wa1Controller = TextEditingController(text: '08123456789');
    _wa2Controller = TextEditingController(text: '085708230036');
  }

  @override
  void dispose() {
    _wa1Controller.dispose();
    _wa2Controller.dispose();
    super.dispose();
  }

  sectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        children: [
          sectionCard('Nomor WhatsApp', [
            LabeledFormFieldWidget(
              controller: _wa1Controller,
              label: 'Nomor WhatsApp 1',
              hintText: 'Masukkan nomor WhatsApp',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _wa2Controller,
              label: 'Nomor WhatsApp 2',
              hintText: 'Masukkan nomor WhatsApp',
              keyboardType: TextInputType.phone,
            ),
          ]),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
