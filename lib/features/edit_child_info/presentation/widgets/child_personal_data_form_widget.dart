import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_dropdown_field_widget.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_form_field_widget.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_radio_group_widget.dart';

class ChildPersonalDataFormWidget extends ConsumerStatefulWidget {
  final bool readOnly;

  const ChildPersonalDataFormWidget({super.key, this.readOnly = false});

  @override
  ConsumerState<ChildPersonalDataFormWidget> createState() =>
      _ChildPersonalDataFormWidgetState();
}

class _ChildPersonalDataFormWidgetState
    extends ConsumerState<ChildPersonalDataFormWidget>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nisController;
  late final TextEditingController _nisnController;
  late final TextEditingController _namaController;
  late final TextEditingController _nikController;
  late final TextEditingController _noKkController;
  late final TextEditingController _noAktaController;
  late final TextEditingController _tempatLahirController;
  late final TextEditingController _noPesertaUjianController;
  late final TextEditingController _noSeriIjazahController;
  late final TextEditingController _noSeriSkhunController;
  late final TextEditingController _noKisController;
  late final TextEditingController _kewarganegaraanLainController;
  late final TextEditingController _statusKeluargaLainController;
  late final TextEditingController _noTeleponController;

  String _jenisKelamin = 'Laki-laki';
  int _anakKe = 1;
  String? _golonganDarah;
  String _statusKeluarga = 'Anak Kandung';
  String? _statusOrangTua;
  String _kewarganegaraan = 'Indonesia';
  String? _agama;
  String _berkebutuhanKhusus = 'Tidak';

  static const _golonganDarahOptions = ['A', 'B', 'AB', 'O'];
  static const _statusOrangTuaOptions = [
    'Lengkap',
    'Yatim',
    'Piatu',
    'Yatim Piatu',
  ];
  static const _agamaOptions = [
    'Islam',
    'Kristen',
    'Katolik',
    'Hindu',
    'Buddha',
    'Konghucu',
    'Lainnya',
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _nisController = TextEditingController();
    _nisnController = TextEditingController();
    _namaController = TextEditingController();
    _nikController = TextEditingController();
    _noKkController = TextEditingController();
    _noAktaController = TextEditingController();
    _tempatLahirController = TextEditingController();
    _noPesertaUjianController = TextEditingController();
    _noSeriIjazahController = TextEditingController();
    _noSeriSkhunController = TextEditingController();
    _noKisController = TextEditingController();
    _kewarganegaraanLainController = TextEditingController();
    _statusKeluargaLainController = TextEditingController();
    _noTeleponController = TextEditingController();
  }

  @override
  void dispose() {
    _nisController.dispose();
    _nisnController.dispose();
    _namaController.dispose();
    _nikController.dispose();
    _noKkController.dispose();
    _noAktaController.dispose();
    _tempatLahirController.dispose();
    _noPesertaUjianController.dispose();
    _noSeriIjazahController.dispose();
    _noSeriSkhunController.dispose();
    _noKisController.dispose();
    _kewarganegaraanLainController.dispose();
    _statusKeluargaLainController.dispose();
    _noTeleponController.dispose();
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
          sectionCard('Data Pribadi', [
            Row(
              children: [
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _nisController,
                    label: 'NIS',
                    hintText: 'NIS',
                    keyboardType: TextInputType.number,
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _nisnController,
                    label: 'NISN',
                    hintText: 'NISN',
                    keyboardType: TextInputType.number,
                    readOnly: isReadOnly,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _namaController,
              label: 'Nama Lengkap',
              hintText: 'Masukkan nama lengkap',
              readOnly: isReadOnly,
            ),
            SizedBox(height: 16.h),
            LabeledRadioGroupWidget(
              label: 'Jenis Kelamin',
              options: const ['Laki-laki', 'Perempuan'],
              groupValue: _jenisKelamin,
              onChanged: isReadOnly
                  ? null
                  : (value) =>
                      setState(() => _jenisKelamin = value ?? 'Laki-laki'),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _nikController,
                    label: 'NIK',
                    hintText: 'NIK',
                    keyboardType: TextInputType.number,
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _noKkController,
                    label: 'No. KK',
                    hintText: 'No. KK',
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
                    controller: _noAktaController,
                    label: 'No. Registrasi Akta Lahir',
                    hintText: 'No. Akta',
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _tempatLahirController,
                    label: 'Tempat Lahir',
                    hintText: 'Tempat Lahir',
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
                    controller: _noPesertaUjianController,
                    label: 'No. Peserta Ujian',
                    hintText: 'No. Peserta Ujian',
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _noSeriIjazahController,
                    label: 'No. Seri Ijazah',
                    hintText: 'No. Seri Ijazah',
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
                    controller: _noSeriSkhunController,
                    label: 'No. Seri SKHUN',
                    hintText: 'No. Seri SKHUN',
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _noKisController,
                    label: 'No. KIS',
                    hintText: 'No. KIS',
                    readOnly: isReadOnly,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anak ke',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: context.brand.textMain,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '$_anakKe',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                color: context.brand.textMain,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            if (!isReadOnly)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        setState(() => _anakKe++),
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 20.sp,
                                      color: context.brand.textMain,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_anakKe > 1) {
                                        setState(() => _anakKe--);
                                      }
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 20.sp,
                                      color: context.brand.textMain,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledDropdownFieldWidget(
                    label: 'Golongan Darah',
                    value: _golonganDarah,
                    items: _golonganDarahOptions,
                    onChanged: isReadOnly
                        ? null
                        : (value) =>
                            setState(() => _golonganDarah = value),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            LabeledRadioGroupWidget(
              label: 'Status Dalam Keluarga',
              options: const ['Anak Kandung', 'Anak Angkat', 'Lainnya'],
              groupValue: _statusKeluarga,
              onChanged: isReadOnly
                  ? null
                  : (value) =>
                      setState(() => _statusKeluarga = value ?? 'Anak Kandung'),
            ),
            SizedBox(height: 8.h),
            LabeledFormFieldWidget(
              controller: _statusKeluargaLainController,
              label: '',
              hintText: 'Status dalam keluarga',
              readOnly: isReadOnly,
            ),
            SizedBox(height: 16.h),
            LabeledDropdownFieldWidget(
              label: 'Status Orang Tua',
              value: _statusOrangTua,
              items: _statusOrangTuaOptions,
              onChanged: isReadOnly
                  ? null
                  : (value) => setState(() => _statusOrangTua = value),
            ),
            SizedBox(height: 16.h),
            LabeledRadioGroupWidget(
              label: 'Kewarganegaraan',
              options: const ['Indonesia', 'Lainnya'],
              groupValue: _kewarganegaraan,
              onChanged: isReadOnly
                  ? null
                  : (value) =>
                      setState(() => _kewarganegaraan = value ?? 'Indonesia'),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: _kewarganegaraan == 'Lainnya'
                  ? Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: LabeledFormFieldWidget(
                        controller: _kewarganegaraanLainController,
                        label: 'Sebutkan Kewarganegaraan',
                        hintText: 'Masukkan kewarganegaraan',
                        readOnly: isReadOnly,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            SizedBox(height: 16.h),
            LabeledDropdownFieldWidget(
              label: 'Agama',
              value: _agama,
              items: _agamaOptions,
              onChanged: isReadOnly
                  ? null
                  : (value) => setState(() => _agama = value),
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _noTeleponController,
              label: 'No. Telepon',
              hintText: 'Masukkan nomor telepon',
              keyboardType: TextInputType.phone,
              readOnly: isReadOnly,
            ),
            SizedBox(height: 16.h),
            LabeledRadioGroupWidget(
              label: 'Berkebutuhan Khusus',
              options: const ['Ya', 'Tidak'],
              groupValue: _berkebutuhanKhusus,
              onChanged: isReadOnly
                  ? null
                  : (value) =>
                      setState(() => _berkebutuhanKhusus = value ?? 'Tidak'),
            ),
          ]),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
