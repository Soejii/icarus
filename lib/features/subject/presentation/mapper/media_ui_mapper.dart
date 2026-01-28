import 'package:flutter/material.dart';
import 'package:gaia/features/subject/domain/types/media_type.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';

extension MediaUiMapper on MediaType {
  String get icon => switch (this) {
        MediaType.youtube => AssetsHelper.imgMediaYoutube,
        MediaType.excel => AssetsHelper.imgMediaExcel,
        MediaType.pdf => AssetsHelper.imgMediaPdf,
        MediaType.ppt => AssetsHelper.imgMediaPpt,
        MediaType.word => AssetsHelper.imgMediaWord,
        MediaType.video => AssetsHelper.imgMediaVideo,
        MediaType.unknown => AssetsHelper.imgSubjectPlaceholder
      };

  Color get color => switch (this) {
        MediaType.youtube => const Color.fromRGBO(255, 210, 210, 1),
        MediaType.excel => const Color.fromRGBO(211, 255, 210, 1),
        MediaType.pdf => const Color.fromRGBO(255, 210, 210, 1),
        MediaType.ppt => const Color.fromRGBO(255, 240, 210, 1),
        MediaType.word => const Color.fromRGBO(210, 239, 255, 1),
        MediaType.video => const Color.fromRGBO(210, 215, 255, 1),
        MediaType.unknown => const Color.fromRGBO(210, 215, 255, 1),
      };
}
