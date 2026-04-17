import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_dropdown_field_widget.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_form_field_widget.dart';

class ChildAdditionalInfoFormWidget extends ConsumerStatefulWidget {
  final bool readOnly;

  const ChildAdditionalInfoFormWidget({super.key, this.readOnly = false});

  @override
  ConsumerState<ChildAdditionalInfoFormWidget> createState() =>
      _ChildAdditionalInfoFormWidgetState();
}

class _ChildAdditionalInfoFormWidgetState
    extends ConsumerState<ChildAdditionalInfoFormWidget>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _tinggalBersamaController;
  late final TextEditingController _jarakController;
  late final TextEditingController _waktuTempuhController;
  late final TextEditingController _tinggiBadanController;
  late final TextEditingController _beratBadanController;
  late final TextEditingController _lingkarKepalaController;

  String? _transportasi;

  static const _transportasiOptions = [
    'Jalan Kaki',
    'Sepeda',
    'Sepeda Motor',
    'Mobil Pribadi',
    'Angkutan Umum',
    'Ojek',
    'Andong',
    'Perahu',
    'Lainnya',
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tinggalBersamaController = TextEditingController();
    _jarakController = TextEditingController();
    _waktuTempuhController = TextEditingController();
    _tinggiBadanController = TextEditingController();
    _beratBadanController = TextEditingController();
    _lingkarKepalaController = TextEditingController();
  }

  @override
  void dispose() {
    _tinggalBersamaController.dispose();
    _jarakController.dispose();
    _waktuTempuhController.dispose();
    _tinggiBadanController.dispose();
    _beratBadanController.dispose();
    _lingkarKepalaController.dispose();
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
          sectionCard('Informasi Tambahan', [
            Row(
              children: [
                Expanded(
                  child: LabeledDropdownFieldWidget(
                    label: 'Transportasi',
                    value: _transportasi,
                    items: _transportasiOptions,
                    onChanged: isReadOnly
                        ? (_) {}
                        : (value) =>
                            setState(() => _transportasi = value),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _tinggalBersamaController,
                    label: 'Tinggal Bersama',
                    hintText: 'Tinggal Bersama',
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
                    controller: _jarakController,
                    label: 'Jarak ke Sekolah (KM)',
                    hintText: 'KM',
                    keyboardType: TextInputType.number,
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _waktuTempuhController,
                    label: 'Waktu Tempuh ke Sekolah (Menit)',
                    hintText: 'Menit',
                    keyboardType: TextInputType.number,
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
                    controller: _tinggiBadanController,
                    label: 'Tinggi Badan (CM)',
                    hintText: 'CM',
                    keyboardType: TextInputType.number,
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _beratBadanController,
                    label: 'Berat Badan (KG)',
                    hintText: 'KG',
                    keyboardType: TextInputType.number,
                    readOnly: isReadOnly,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _lingkarKepalaController,
              label: 'Lingkar Kepala (CM)',
              hintText: 'CM',
              keyboardType: TextInputType.number,
              readOnly: isReadOnly,
            ),
          ]),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
