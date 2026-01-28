import 'package:flutter/material.dart';
import 'package:icarus/features/profile/presentation/widgets/profile_menu_button.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProfileMenuData> listMenuButton = [
      ProfileMenuData(icon: Icons.person, label: 'Informasi Akun', path: 'account-information'),
      ProfileMenuData(icon: Icons.lock, label: 'Ubah Kata Sandi', path: 'change-password'),
      ProfileMenuData(icon: Icons.help, label: 'Bantuan', path: ''),
      ProfileMenuData(icon: Icons.info, label: 'Informasi Sekolah', path: 'school-information'),
      ProfileMenuData(icon: Icons.shield, label: 'Kebijakan Privasi', path: 'privacy-policy'),
      ProfileMenuData(icon: Icons.logout, label: 'Logout', path: 'logout'),
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listMenuButton.length,
      itemBuilder: (context, index) => ProfileMenuButton(
        icon: listMenuButton[index].icon,
        label: listMenuButton[index].label,
        path: listMenuButton[index].path,
      ),
    );
  }
}

class ProfileMenuData {
  final IconData icon;
  final String label;
  final String path;

  ProfileMenuData({
    required this.icon,
    required this.label,
    required this.path,
  });
}
