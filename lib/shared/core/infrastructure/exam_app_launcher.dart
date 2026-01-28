import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

class ExamAppLauncher {

  /// Opens the Exam App with the provided [examId], [examType] or straight up go to google play store.
  static Future<void> openExam(int examId, String examType) async {
  const packageName = 'com.cbt.sidigs.karna';
  final intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      data: 'examapp://exam?id=$examId&type=$examType',
      package: 'com.cbt.sidigs.karna',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );

  try {
    await intent.launch();
  } catch (e) {
    // Fallback to Play Store if not installed
    const storeIntent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      data: 'https://play.google.com/store/apps/details?id=$packageName',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    await storeIntent.launch();
  }
}
}
