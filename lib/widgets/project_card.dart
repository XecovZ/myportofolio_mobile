import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/achievement_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _handleTap(BuildContext context) async {
    switch (item.name) {
      case 'Lihat Proyek':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProjectListScreen()),
        );
      case 'Tambah Proyek':
        if (!await ensureLoggedIn(context)) return;
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProjectFormPage()),
        );
      case 'Tambah Achievement':
        if (!await ensureLoggedIn(context)) return;
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AchievementFormPage()),
        );
      case 'Logout':
        final auth = context.read<AuthState>();
        if (!auth.isLoggedIn) {
          _showSnackBar(context, 'Kamu belum login.');
          return;
        }
        await auth.logout();
        if (!context.mounted) return;
        _showSnackBar(context, 'Berhasil logout.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _handleTap(context),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
