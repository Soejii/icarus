import 'package:url_launcher/url_launcher.dart';

class ExamAppLauncher {
  static Future<void> openExam(int examId, String examType) async {
    const packageName = 'com.cbt.sidigs.karna';
    final examUri = Uri.parse('examapp://exam?id=$examId&type=$examType');
    final storeUri = Uri.parse(
      'https://play.google.com/store/apps/details?id=$packageName',
    );

    if (await canLaunchUrl(examUri)) {
      await launchUrl(examUri, mode: LaunchMode.externalApplication);
      return;
    }

    await launchUrl(storeUri, mode: LaunchMode.externalApplication);
  }
}
