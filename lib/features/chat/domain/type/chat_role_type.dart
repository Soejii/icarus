enum ChatRole {
  student,
  teacher,
  parent,
  unknown;

  String get displayName {
    switch (this) {
      case ChatRole.student:
        return 'student';
      case ChatRole.teacher:
        return 'teacher';
      case ChatRole.parent:
        return 'Orang tua';
      case ChatRole.unknown:
        return 'unknown';
    }
  }

  String get label {
    switch (this) {
      case ChatRole.student:
        return 'Murid';
      case ChatRole.teacher:
        return 'Guru';
      case ChatRole.parent:
        return 'Orang tua';
      case ChatRole.unknown:
        return 'Tidak Diketahui';
    }
  }

  static ChatRole? fromString(String? roleString) {
    if (roleString == null || roleString.isEmpty) return ChatRole.unknown;

    switch (roleString.toLowerCase()) {
      case 'student':
        return ChatRole.student;
      case 'teacher':
        return ChatRole.teacher;
      case 'parent':
        return ChatRole.parent;
      default:
        return ChatRole.unknown;
    }
  }
}
