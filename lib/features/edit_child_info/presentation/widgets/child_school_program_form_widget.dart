import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_form_field_widget.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_radio_group_widget.dart';

class ChildSchoolProgramFormWidget extends ConsumerStatefulWidget {
  final bool readOnly;

  const ChildSchoolProgramFormWidget({super.key, this.readOnly = false});

  @override
  ConsumerState<ChildSchoolProgramFormWidget> createState() =>
      _ChildSchoolProgramFormWidgetState();
}

class _ChildSchoolProgramFormWidgetState
    extends ConsumerState<ChildSchoolProgramFormWidget>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _sekolahAsalController;
  late final TextEditingController _alamatSekolahAsalController;
  late final TextEditingController _noKpsController;
  late final TextEditingController _noKipController;
  late final TextEditingController _noKksController;
  late final TextEditingController _alasanPipController;

  String _penerimaKps = 'Tidak';
  String _penerimaKip = 'Tidak';
  String _layakPip = 'Tidak';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _sekolahAsalController = TextEditingController();
    _alamatSekolahAsalController = TextEditingController();
    _noKpsController = TextEditingController();
    _noKipController = TextEditingController();
    _noKksController = TextEditingController();
    _alasanPipController = TextEditingController();
  }

  @override
  void dispose() {
    _sekolahAsalController.dispose();
    _alamatSekolahAsalController.dispose();
    _noKpsController.dispose();
    _noKipController.dispose();
    _noKksController.dispose();
    _alasanPipController.dispose();
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
    super.build(context);
    final isReadOnly = widget.readOnly;

    return Form(
      key: _formKey,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        children: [
          sectionCard('Informasi Sekolah', [
            Row(
              children: [
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _sekolahAsalController,
                    label: 'Sekolah Asal',
                    hintText: 'Sekolah Asal',
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _alamatSekolahAsalController,
                    label: 'Alamat Sekolah Asal',
                    hintText: 'Alamat Sekolah Asal',
                    readOnly: isReadOnly,
                  ),
                ),
              ],
            ),
          ]),
          SizedBox(height: 16.h),
          sectionCard('Informasi Program', [
            LabeledRadioGroupWidget(
              label: 'Penerima KPS',
              options: const ['Ya', 'Tidak'],
              groupValue: _penerimaKps,
              onChanged: isReadOnly
                  ? (_) {}
                  : (value) =>
                      setState(() => _penerimaKps = value ?? 'Tidak'),
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _noKpsController,
              label: 'No. KPS',
              hintText: 'No. KPS',
              readOnly: isReadOnly,
            ),
            SizedBox(height: 16.h),
            LabeledRadioGroupWidget(
              label: 'Penerima KIP',
              options: const ['Ya', 'Tidak'],
              groupValue: _penerimaKip,
              onChanged: isReadOnly
                  ? (_) {}
                  : (value) =>
                      setState(() => _penerimaKip = value ?? 'Tidak'),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _noKipController,
                    label: 'No. KIP',
                    hintText: 'No. KIP',
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _noKksController,
                    label: 'No. KKS',
                    hintText: 'No. KKS',
                    readOnly: isReadOnly,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            LabeledRadioGroupWidget(
              label: 'Layak PIP',
              options: const ['Ya', 'Tidak'],
              groupValue: _layakPip,
              onChanged: isReadOnly
                  ? (_) {}
                  : (value) =>
                      setState(() => _layakPip = value ?? 'Tidak'),
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _alasanPipController,
              label: 'Alasan Layak PIP',
              hintText: 'Alasan Layak PIP',
              readOnly: isReadOnly,
            ),
          ]),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
