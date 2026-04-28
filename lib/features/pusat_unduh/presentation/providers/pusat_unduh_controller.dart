import 'package:icarus/features/pusat_unduh/domain/entities/pusat_unduh_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pusat_unduh_controller.g.dart';

@riverpod
class PusatUnduhController extends _$PusatUnduhController {
  @override
  List<PusatUnduhEntity> build() {
    return [
      PusatUnduhEntity(
        id: 1,
        judul: 'PARENT HANDBOOK',
        pengunggah: 'Admin SMA Pendekar',
        tanggalMulaiTerbit: '2025-07-25 08:43:00 WIB',
        tanggalSelesaiTerbit: '2025-07-25 08:43:00 WIB',
        lampiranUrl: 'https://example.com/parent-handbook-1.pdf',
      ),
      PusatUnduhEntity(
        id: 2,
        judul: 'PARENT HANDBOOK',
        pengunggah: 'Admin SMA Pendekar',
        tanggalMulaiTerbit: '2025-06-01 09:00:00 WIB',
        tanggalSelesaiTerbit: '2025-06-30 09:00:00 WIB',
        lampiranUrl: 'https://example.com/parent-handbook-2.pdf',
      ),
      PusatUnduhEntity(
        id: 3,
        judul: 'PARENT HANDBOOK',
        pengunggah: 'Admin SMA Pendekar',
        tanggalMulaiTerbit: '2025-05-01 08:00:00 WIB',
        tanggalSelesaiTerbit: '2025-05-31 08:00:00 WIB',
        lampiranUrl: 'https://example.com/parent-handbook-3.pdf',
      ),
      PusatUnduhEntity(
        id: 4,
        judul: 'PARENT HANDBOOK',
        pengunggah: 'Admin SMA Pendekar',
        tanggalMulaiTerbit: '2025-04-01 07:30:00 WIB',
        tanggalSelesaiTerbit: '2025-04-30 07:30:00 WIB',
        lampiranUrl: 'https://example.com/parent-handbook-4.pdf',
      ),
    ];
  }
}
