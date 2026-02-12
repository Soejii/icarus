class AssetsHelper {
  static String imgProfilePlaceholder = img("img_profile_placeholder.png");
  static String imgAnnouncementPlaceholder =
      img('img_announcement_placeholder.png');

  static String imgQuiz = img("img_quiz.png");
  static String imgSubjectPlaceholder = img("img_subject_placeholder.png");

  static String imgHomeButtonMapel = img("img_home_mapel.png");
  static String imgHomeButtonDiskusi = img("img_home_diskusi.png");
  static String imgHomeButtonKehadiran = img("img_home_presensi.png");
  static String imgHomeButtonJadwal = img("img_home_jadwal.png");
  static String imgHomeButtonPengumuman = img("img_home_pengumuman.png");
  static String imgHomeButtonEdutainment = img("img_home_edutainment.png");
  static String imgHomeButtonKeuangan = img("img_home_keuangan.png");
  static String imgHomeButtonCbt = img("img_home_keuangan.png");

  static String imgTidakAdaPelajaran = img("img_tidak_ada_pelajaran.png");

  static String imgDataNotFound = img('img_data_not_found.png');
  static String imgNetworkError = img('img_no_internet.png');
  static String imgUnknownError = img('img_error.png');

  static String imgSuccess = img('img_done.png');

  static String imgChatNotFound = img('img_chat_not_found.png');

  static String icHome = icon('ic_beranda_home.svg');
  static String icPerformance = icon('ic_performance_home.svg');
  static String icChat = icon('ic_chat_home.svg');
  static String icProfile = icon('ic_profile_home.svg');
  static String icSaving = icon('ic_saving.svg');
  static String icEmoney = icon('ic_emoney.svg');
  static String icTopup = icon('ic_topup.svg');
  static String icCashout = icon('ic_cashout.svg');
  static String icChooseDiscussion = icon('ic_choose_discussion.svg');

  static String icon(String name) {
    return "assets/icons/$name";
  }

  static String img(String name) {
    return "assets/images/$name";
  }
}
