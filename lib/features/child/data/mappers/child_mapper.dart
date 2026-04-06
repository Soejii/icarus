import 'package:icarus/features/child/data/models/child_model.dart';
import 'package:icarus/features/child/domain/entities/child_entity.dart';

extension ChildMapper on ChildModel {
  ChildEntity toEntity() => ChildEntity(
        id: id,
        name: name,
        nis: nis,
        nickname: nickname,
        photo: photo,
        className: className,
      );
}
