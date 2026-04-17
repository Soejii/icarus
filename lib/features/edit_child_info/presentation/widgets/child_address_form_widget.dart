import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_form_field_widget.dart';

class ChildAddressFormWidget extends ConsumerStatefulWidget {
  final bool readOnly;

  const ChildAddressFormWidget({super.key, this.readOnly = false});

  @override
  ConsumerState<ChildAddressFormWidget> createState() =>
      _ChildAddressFormWidgetState();
}

class _ChildAddressFormWidgetState extends ConsumerState<ChildAddressFormWidget>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _alamatController;
  late final TextEditingController _rtController;
  late final TextEditingController _rwController;
  late final TextEditingController _dusunController;
  late final TextEditingController _kecamatanController;
  late final TextEditingController _kelurahanController;
  late final TextEditingController _kabupatenController;
  late final TextEditingController _kodePosController;
  late final TextEditingController _nomorRumahController;
  late final TextEditingController _lintangController;
  late final TextEditingController _bujurController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _alamatController = TextEditingController();
    _rtController = TextEditingController();
    _rwController = TextEditingController();
    _dusunController = TextEditingController();
    _kecamatanController = TextEditingController();
    _kelurahanController = TextEditingController();
    _kabupatenController = TextEditingController();
    _kodePosController = TextEditingController();
    _nomorRumahController = TextEditingController();
    _lintangController = TextEditingController();
    _bujurController = TextEditingController();
  }

  @override
  void dispose() {
    _alamatController.dispose();
    _rtController.dispose();
    _rwController.dispose();
    _dusunController.dispose();
    _kecamatanController.dispose();
    _kelurahanController.dispose();
    _kabupatenController.dispose();
    _kodePosController.dispose();
    _nomorRumahController.dispose();
    _lintangController.dispose();
    _bujurController.dispose();
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
          sectionCard('Data Alamat', [
            LabeledFormFieldWidget(
              controller: _alamatController,
              label: 'Alamat',
              hintText: 'Alamat Lengkap',
              maxLines: 3,
              minLines: 3,
              readOnly: isReadOnly,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _rtController,
                    label: 'RT',
                    hintText: 'RT',
                    keyboardType: TextInputType.number,
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _rwController,
                    label: 'RW',
                    hintText: 'RW',
                    keyboardType: TextInputType.number,
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _dusunController,
                    label: 'Dusun',
                    hintText: 'Dusun',
                    readOnly: isReadOnly,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _kecamatanController,
                    label: 'Kecamatan',
                    hintText: 'Kecamatan',
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _kelurahanController,
                    label: 'Kelurahan',
                    hintText: 'Kelurahan',
                    readOnly: isReadOnly,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _kabupatenController,
                    label: 'Kabupaten',
                    hintText: 'Kabupaten',
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _kodePosController,
                    label: 'Kode Pos',
                    hintText: 'Kode Pos',
                    keyboardType: TextInputType.number,
                    readOnly: isReadOnly,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _nomorRumahController,
              label: 'Nomor Rumah',
              hintText: 'Nomor Rumah',
              readOnly: isReadOnly,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _lintangController,
                    label: 'Lintang',
                    hintText: 'Lintang',
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _bujurController,
                    label: 'Bujur',
                    hintText: 'Bujur',
                    readOnly: isReadOnly,
                  ),
                ),
              ],
            ),
          ]),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
