import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/absence_letter/domain/entities/submit_absence_letter_request.dart';
import 'package:icarus/features/absence_letter/presentation/providers/absence_letter_form_controller.dart';
import 'package:icarus/features/absence_letter/presentation/providers/absence_letter_history_controller.dart';
import 'package:icarus/features/absence_letter/presentation/providers/absence_letter_providers.dart';
import 'package:icarus/features/absence_letter/presentation/providers/submit_absence_letter_controller.dart';
import 'package:icarus/features/absence_letter/presentation/widgets/absence_letter_history_list_widget.dart';
import 'package:icarus/features/absence_letter/presentation/widgets/absence_letter_tab_toggle_widget.dart';
import 'package:icarus/features/absence_letter/presentation/widgets/create_absence_letter_form_widget.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/shared/core/types/failure.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class AbsenceLetterScreen extends ConsumerWidget {
  const AbsenceLetterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(absenceLetterTabIndexProvider);
    final childrenAsync = ref.watch(childListControllerProvider);
    final selectedChild = ref.watch(selectedChildProvider);
    final submitAsync = ref.watch(submitAbsenceLetterControllerProvider);

    ref.listen(childListControllerProvider, (_, next) {
      next.whenData((children) {
        if (children.isNotEmpty && ref.read(selectedChildProvider) == null) {
          ref.read(selectedChildProvider.notifier).select(children.first);
        }
      });
    });

    ref.listen(submitAbsenceLetterControllerProvider, (previous, next) {
      if (previous?.isLoading == true && next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
      if (previous?.isLoading == true && next.hasValue) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Surat izin berhasil dibuat')),
        );
        ref.read(absenceLetterFormControllerProvider.notifier).reset();
        ref.read(absenceLetterTabIndexProvider.notifier).state = 1;
        ref.read(absenceLetterHistoryControllerProvider.notifier).refresh();
      }
    });

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Surat Ijin',
        leadingIcon: true,
      ),
      body: childrenAsync.when(
        data: (children) {
          if (children.isEmpty) {
            return BufferErrorView(
              error: UnknownFailure(
                'Tidak ada data murid',
                stackTrace: StackTrace.current,
              ),
              onRetry: () => ref.invalidate(childListControllerProvider),
            );
          }
          final child = selectedChild ?? children.first;
          return Column(
            children: [
              const AbsenceLetterTabToggleWidget(),
              Expanded(
                child: tabIndex == 0
                    ? CreateAbsenceLetterFormWidget(
                        studentName: child.name,
                        studentClass: child.className ?? '-',
                      )
                    : const AbsenceLetterHistoryListWidget(),
              ),
            ],
          );
        },
        error: (error, stack) => BufferErrorView(
          error: error,
          stackTrace: stack,
          onRetry: () => ref.invalidate(childListControllerProvider),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: tabIndex == 0
          ? submitButton(context, ref, submitAsync.isLoading)
          : null,
    );
  }

  submitButton(BuildContext context, WidgetRef ref, bool isLoading) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.invertedShadow,
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 56.h,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: context.brand.mainGradient,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: context.brand.shadow,
            ),
            child: ElevatedButton(
              onPressed: isLoading ? null : () => submit(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      width: 22.r,
                      height: 22.r,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Buat Surat Izin',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.8,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit(BuildContext context, WidgetRef ref) async {
    final child = ref.read(selectedChildProvider);
    final form = ref.read(absenceLetterFormControllerProvider);
    final error = validate(childExists: child != null, form: form);
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    await ref.read(submitAbsenceLetterControllerProvider.notifier).submit(
          SubmitAbsenceLetterRequest(
            studentId: child!.id,
            status: form.status,
            evidencePath: form.evidencePath!,
            notes: form.notes.trim(),
            startDate: formatDate(form.startDate!),
            endDate: formatDate(form.endDate!),
          ),
        );
  }

  String? validate({
    required bool childExists,
    required AbsenceLetterFormState form,
  }) {
    if (!childExists) return 'Pilih murid terlebih dahulu';
    if (form.status != 'sick' && form.status != 'permit') {
      return 'Pilih alasan tidak hadir';
    }
    if (form.notes.trim().isEmpty) return 'Keterangan wajib diisi';
    if (form.startDate == null) return 'Tanggal mulai wajib dipilih';
    if (form.endDate == null) return 'Tanggal selesai wajib dipilih';
    if (form.endDate!.isBefore(form.startDate!)) {
      return 'Tanggal selesai tidak boleh sebelum tanggal mulai';
    }
    if (form.evidencePath == null) return 'Lampiran wajib dipilih';
    return null;
  }

  String formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}
