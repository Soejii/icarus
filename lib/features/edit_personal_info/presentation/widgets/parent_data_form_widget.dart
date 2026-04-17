import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_dropdown_field_widget.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_form_field_widget.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_radio_group_widget.dart';

class ParentDataFormWidget extends ConsumerStatefulWidget {
  final String parentLabel;

  const ParentDataFormWidget({super.key, required this.parentLabel});

  @override
  ConsumerState<ParentDataFormWidget> createState() =>
      _ParentDataFormWidgetState();
}

class _ParentDataFormWidgetState extends ConsumerState<ParentDataFormWidget> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nikController;
  late final TextEditingController _namaController;
  late final TextEditingController _tempatLahirController;
  late final TextEditingController _tanggalLahirController;
  late final TextEditingController _kewarganegaraanLainController;
  late final TextEditingController _alamatController;
  late final TextEditingController _pekerjaanController;
  late final TextEditingController _tempatKerjaController;
  late final TextEditingController _noTeleponController;
  late final TextEditingController _emailController;

  String _kewarganegaraan = 'Indonesia';
  String? _agama;
  String? _pendidikan;
  String? _penghasilan;
  String _berkebutuhanKhusus = 'Tidak';

  static const _agamaOptions = [
    'Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu', 'Lainnya',
  ];
  static const _pendidikanOptions = [
    'SD', 'SMP', 'SMA/SMK', 'D3', 'S1', 'S2', 'S3', 'Lainnya',
  ];
  static const _penghasilanOptions = [
    '< Rp1.000.000',
    'Rp1jt - Rp2,9jt',
    'Rp3jt - Rp4,9jt',
    'Rp5jt - Rp9,9jt',
    '> Rp10.000.000',
  ];
  static const _bulanIndonesia = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];

  @override
  void initState() {
    super.initState();
    _nikController = TextEditingController();
    _namaController = TextEditingController();
    _tempatLahirController = TextEditingController();
    _tanggalLahirController = TextEditingController();
    _kewarganegaraanLainController = TextEditingController();
    _alamatController = TextEditingController();
    _pekerjaanController = TextEditingController();
    _tempatKerjaController = TextEditingController();
    _noTeleponController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nikController.dispose();
    _namaController.dispose();
    _tempatLahirController.dispose();
    _tanggalLahirController.dispose();
    _kewarganegaraanLainController.dispose();
    _alamatController.dispose();
    _pekerjaanController.dispose();
    _tempatKerjaController.dispose();
    _noTeleponController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_bulanIndonesia[date.month - 1]} ${date.year}';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = _formatDate(picked);
      });
    }
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
          sectionCard('Identitas Diri', [
            LabeledFormFieldWidget(
              controller: _nikController,
              label: 'NIK',
              hintText: 'Masukkan NIK',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _namaController,
              label: 'Nama Lengkap',
              hintText: 'Masukkan nama lengkap',
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _tempatLahirController,
              label: 'Tempat Lahir',
              hintText: 'Masukkan tempat lahir',
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _tanggalLahirController,
              label: 'Tanggal Lahir',
              hintText: 'Pilih tanggal lahir',
              readOnly: true,
              onTap: _pickDate,
              suffixIcon: Icon(Icons.calendar_today_outlined, size: 18.r),
            ),
            SizedBox(height: 16.h),
            LabeledRadioGroupWidget(
              label: 'Kewarganegaraan',
              options: const ['Indonesia', 'Lainnya'],
              groupValue: _kewarganegaraan,
              onChanged: (value) =>
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
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            SizedBox(height: 16.h),
            LabeledDropdownFieldWidget(
              label: 'Agama',
              value: _agama,
              items: _agamaOptions,
              onChanged: (value) => setState(() => _agama = value),
            ),
          ]),
          SizedBox(height: 16.h),
          sectionCard('Alamat', [
            LabeledFormFieldWidget(
              controller: _alamatController,
              label: 'Alamat',
              hintText: 'Masukkan alamat lengkap',
              maxLines: 3,
              minLines: 3,
            ),
          ]),
          SizedBox(height: 16.h),
          sectionCard('Pekerjaan', [
            LabeledDropdownFieldWidget(
              label: 'Pendidikan',
              value: _pendidikan,
              items: _pendidikanOptions,
              onChanged: (value) => setState(() => _pendidikan = value),
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _pekerjaanController,
              label: 'Pekerjaan',
              hintText: 'Masukkan pekerjaan',
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _tempatKerjaController,
              label: 'Tempat Kerja',
              hintText: 'Masukkan tempat kerja',
            ),
            SizedBox(height: 16.h),
            LabeledDropdownFieldWidget(
              label: 'Penghasilan',
              value: _penghasilan,
              items: _penghasilanOptions,
              onChanged: (value) => setState(() => _penghasilan = value),
            ),
          ]),
          SizedBox(height: 16.h),
          sectionCard('Kontak', [
            LabeledFormFieldWidget(
              controller: _noTeleponController,
              label: 'No. Telepon',
              hintText: 'Masukkan nomor telepon',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.h),
            LabeledFormFieldWidget(
              controller: _emailController,
              label: 'Email',
              hintText: 'Masukkan email',
              keyboardType: TextInputType.emailAddress,
            ),
          ]),
          SizedBox(height: 16.h),
          sectionCard('Kebutuhan Khusus', [
            LabeledRadioGroupWidget(
              label: 'Berkebutuhan Khusus',
              options: const ['Ya', 'Tidak'],
              groupValue: _berkebutuhanKhusus,
              onChanged: (value) =>
                  setState(() => _berkebutuhanKhusus = value ?? 'Tidak'),
            ),
          ]),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
