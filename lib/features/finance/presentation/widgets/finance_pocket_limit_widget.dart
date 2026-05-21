import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/providers/spending_limit_controller.dart';

class FinancePocketLimitWidget extends ConsumerStatefulWidget {
  const FinancePocketLimitWidget({super.key});

  @override
  ConsumerState<FinancePocketLimitWidget> createState() =>
      _FinancePocketLimitWidgetState();
}

class _FinancePocketLimitWidgetState
    extends ConsumerState<FinancePocketLimitWidget> {
  String _selectedPeriod = 'Tidak Dibatasi';
  final _nominalController = TextEditingController(text: '0');
  bool _formEdited = false;
  bool _saving = false;

  final _periods = [
    'Tidak Dibatasi',
    'Harian',
    'Mingguan',
    'Bulanan',
    'Tahunan',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final limit = ref.read(spendingLimitControllerProvider).valueOrNull;
      if (limit != null && !_formEdited) {
        _nominalController.text = limit.amount?.toString() ?? '0';
        _selectedPeriod = limit.type;
      }
    });
  }

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final limitAsync = ref.watch(spendingLimitControllerProvider);

    if (limitAsync.hasValue && !_formEdited) {
      final limit = limitAsync.valueOrNull;
      if (limit != null && _nominalController.text != (limit.amount?.toString() ?? '0')) {
        _nominalController.text = limit.amount?.toString() ?? '0';
      }
      if (limit != null && _selectedPeriod != limit.type) {
        _selectedPeriod = limit.type;
      }
    }

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
            'Batas Uang Jajan',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Nominal',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 6.h),
            TextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              onChanged: (_) {
                if (!_formEdited) {
                  setState(() => _formEdited = true);
                }
              },
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
            decoration: InputDecoration(
              prefixText: 'Rp ',
              prefixStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.brand.textMain,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Periode',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedPeriod,
                isExpanded: true,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textMain,
                ),
                items: _periods
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedPeriod = value;
                      _formEdited = true;
                    });
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: context.brand.mainGradient,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ElevatedButton(
                onPressed: _saving
                    ? null
                    : () async {
                        setState(() => _saving = true);
                        try {
                          await ref.read(spendingLimitControllerProvider.notifier).setLimit(
                                _selectedPeriod,
                                _selectedPeriod == 'Tidak Dibatasi'
                                    ? null
                                    : int.tryParse(_nominalController.text),
                              );
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Batas uang jajan berhasil disimpan')),
                            );
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() => _saving = false);
                          }
                        }
                      },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: _saving
                    ? SizedBox(
                        width: 18.w,
                        height: 18.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Simpan',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
