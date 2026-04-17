import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_form_field_widget.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/labeled_radio_group_widget.dart';

class ChildBankInfoFormWidget extends ConsumerStatefulWidget {
  final bool readOnly;

  const ChildBankInfoFormWidget({super.key, this.readOnly = false});

  @override
  ConsumerState<ChildBankInfoFormWidget> createState() =>
      _ChildBankInfoFormWidgetState();
}

class _ChildBankInfoFormWidgetState
    extends ConsumerState<ChildBankInfoFormWidget>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _bankController;
  late final TextEditingController _noRekeningController;
  late final TextEditingController _mutasiDariController;
  late final TextEditingController _kebutuhanKhususController;

  String _mutasi = 'Tidak';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bankController = TextEditingController();
    _noRekeningController = TextEditingController();
    _mutasiDariController = TextEditingController();
    _kebutuhanKhususController = TextEditingController();
  }

  @override
  void dispose() {
    _bankController.dispose();
    _noRekeningController.dispose();
    _mutasiDariController.dispose();
    _kebutuhanKhususController.dispose();
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
          sectionCard('Informasi Bank', [
            Row(
              children: [
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _bankController,
                    label: 'Bank',
                    hintText: 'Bank',
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _noRekeningController,
                    label: 'No. Rekening',
                    hintText: 'No. Rekening',
                    keyboardType: TextInputType.number,
                    readOnly: isReadOnly,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            LabeledRadioGroupWidget(
              label: 'Mutasi',
              options: const ['Ya', 'Tidak'],
              groupValue: _mutasi,
              onChanged: isReadOnly
                  ? null
                  : (value) =>
                      setState(() => _mutasi = value ?? 'Tidak'),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _mutasiDariController,
                    label: 'Mutasi Dari',
                    hintText: 'Mutasi Dari',
                    readOnly: isReadOnly,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledFormFieldWidget(
                    controller: _kebutuhanKhususController,
                    label: 'Kebutuhan Khusus',
                    hintText: 'Kebutuhan Khusus',
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
