import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text(
              'User Name', // Nanti bisa ambil dari DashboardData
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Administrator'),
            const SizedBox(height: 32),
            _buildProfileMenu(Icons.settings, 'Pengaturan Akun'),
            _buildProfileMenu(Icons.help_outline, 'Pusat Bantuan'),
            _buildProfileMenu(Icons.logout, 'Keluar', color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenu(IconData icon, String title, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black87),
      title: Text(title, style: TextStyle(color: color ?? Colors.black87)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}