import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/rapor/presentation/providers/rapor_pdf_controller.dart';
import 'package:icarus/features/rapor/presentation/screens/rapor_pdf_viewer_args.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class RaporPdfViewerScreen extends ConsumerStatefulWidget {
  const RaporPdfViewerScreen({super.key, required this.args});

  final RaporPdfViewerArgs args;

  @override
  ConsumerState<RaporPdfViewerScreen> createState() =>
      _RaporPdfViewerScreenState();
}

class _RaporPdfViewerScreenState extends ConsumerState<RaporPdfViewerScreen> {
  int _currentPage = 0;
  int _totalPages = 0;
  bool _showPageCounter = false;
  Timer? _hideTimer;
  bool _isSavingToDevice = false;

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      raporPdfControllerProvider(
        widget.args.fileUrl,
        widget.args.suggestedFileName,
      ),
    );

    return Scaffold(
      appBar: viewerAppBar(context, state),
      body: Stack(
        children: [
          pdfContent(context, state),
          if (state.isReady && _showPageCounter) pageCounter(context),
        ],
      ),
    );
  }

  PreferredSize viewerAppBar(BuildContext context, RaporPdfState state) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(gradient: context.brand.mainGradient),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
                Expanded(
                  child: Text(
                    widget.args.suggestedFileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: _isSavingToDevice
                      ? SizedBox(
                          width: 18.r,
                          height: 18.r,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.download_rounded,
                          color: Colors.white,
                        ),
                  onPressed: state.isReady && !_isSavingToDevice
                      ? _downloadToDevice
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pdfContent(BuildContext context, RaporPdfState state) {
    if (state.isDownloading) return downloadingView(context, state);
    if (state.isError) {
      return BufferErrorView(
        error: state.error!,
        onRetry: () => ref
            .read(
              raporPdfControllerProvider(
                widget.args.fileUrl,
                widget.args.suggestedFileName,
              ).notifier,
            )
            .retry(widget.args.fileUrl, widget.args.suggestedFileName),
      );
    }

    return PDFView(
      filePath: state.localPath!,
      onPageChanged: (page, total) => _onPageChanged(page ?? 0, total ?? 0),
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: true,
      pageFling: true,
      fitPolicy: FitPolicy.WIDTH,
    );
  }

  Widget downloadingView(BuildContext context, RaporPdfState state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.picture_as_pdf_rounded,
              size: 64.r,
              color: context.brand.primary,
            ),
            SizedBox(height: 16.h),
            Text(
              'Mengunduh dokumen...',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: context.brand.textMain,
              ),
            ),
            SizedBox(height: 12.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: LinearProgressIndicator(
                value: state.progress > 0 ? state.progress : null,
                minHeight: 6.h,
                backgroundColor: context.brand.inactive.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation(context.brand.primary),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${(state.progress * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                color: context.brand.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageCounter(BuildContext context) {
    return Positioned(
      bottom: 24.h,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: _showPageCounter ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: context.brand.textMain.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '${_currentPage + 1} / $_totalPages',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPageChanged(int page, int total) {
    _hideTimer?.cancel();
    setState(() {
      _currentPage = page;
      _totalPages = total;
      _showPageCounter = true;
    });
    _hideTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _showPageCounter = false);
    });
  }

  Future<void> _downloadToDevice() async {
    final state = ref.read(
      raporPdfControllerProvider(
        widget.args.fileUrl,
        widget.args.suggestedFileName,
      ),
    );
    final localPath = state.localPath;
    if (localPath == null) return;

    setState(() => _isSavingToDevice = true);
    try {
      final docsDir = await getApplicationDocumentsDirectory();
      final raporDir = Directory('${docsDir.path}/Rapor');
      if (!await raporDir.exists()) {
        await raporDir.create(recursive: true);
      }
      final safeName = widget.args.suggestedFileName.replaceAll(
        RegExp(r'[^a-zA-Z0-9._-]'),
        '_',
      );
      final destPath = '${raporDir.path}/$safeName';
      await File(localPath).copy(destPath);
      if (!mounted) return;
      final result = await OpenFile.open(destPath);
      if (!mounted) return;
      if (result.type != ResultType.done) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tersimpan di $destPath')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rapor berhasil disimpan dan dibuka')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan dokumen')),
      );
    } finally {
      if (mounted) setState(() => _isSavingToDevice = false);
    }
  }
}
