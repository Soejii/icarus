import 'package:gaia/features/subject/data/models/subject_model.dart';
import 'package:gaia/features/subject/domain/entities/subject_entity.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';

extension SubjectMapper on SubjectModel {
  SubjectEntity toEntity() => SubjectEntity(
        id: id,
        name: name,
        iconCode: iconImage(iconCode ?? ''),
      );

  String iconImage(String iconCode) {
    switch (iconCode) {
      case 'senbud':
        return AssetsHelper.imgSubjectSeni;
      case 'pai':
        return AssetsHelper.imgSubjectPai;
      case 'ipa':
        return AssetsHelper.imgSubjectIpa;
      case 'ekonomi':
        return AssetsHelper.imgSubjectEkonomi;
      case 'kimia':
        return AssetsHelper.imgSubjectKimia;
      case 'sosiologi':
        return AssetsHelper.imgSubjectIps;
      case 'ips':
        return AssetsHelper.imgSubjectIps;
      case 'geografi':
        return AssetsHelper.imgSubjectGeografi;
      case 'bind':
        return AssetsHelper.imgSubjectIndonesia;
      case 'tik':
        return AssetsHelper.imgSubjectTik;
      case 'mtk':
        return AssetsHelper.imgSubjectMatematika;
      case 'pkn':
        return AssetsHelper.imgSubjectKewarganegaraan;
      case 'fisika':
        return AssetsHelper.imgSubjectFisika;
      case 'biologi':
        return AssetsHelper.imgSubjectBiologi;
      case 'sejarah':
        return AssetsHelper.imgSubjectSejarah;
      case 'bing':
        return AssetsHelper.imgSubjectInggris;
      default:
        return AssetsHelper.imgSubjectPlaceholder;
    }
  }
}
