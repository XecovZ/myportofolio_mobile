import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/achievement_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),

          // Home
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),

          // Project list (public)
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Projects'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectListScreen(),
                ),
              );
            },
          ),

          // Add Project (requires login)
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () async {
              if (!await ensureLoggedIn(context)) return;
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectFormPage(),
                ),
              );
            },
          ),

          // Add Achievement (requires login)
          ListTile(
            leading: const Icon(Icons.emoji_events_outlined),
            title: const Text('Add Achievement'),
            onTap: () async {
              if (!await ensureLoggedIn(context)) return;
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AchievementFormPage(),
                ),
              );
            },
          ),

          const Divider(),

          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () async {
                final loggedIn = await ensureLoggedIn(context);
                if (!loggedIn || !context.mounted) return;
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Logged in.')));
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await context.read<AuthState>().logout();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Logged out.')));
              },
            ),
        ],
      ),
    );
  }
}
