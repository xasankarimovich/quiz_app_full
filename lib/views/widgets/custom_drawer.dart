import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/views/screens/setting_screen.dart';

import '../../utils/image_path/images_path.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue.shade900,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppImages.onHasan),
            const DrawerHeader(
              child: SizedBox(),
            ),
            ListTile(
              title: const Text(
                "Home",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Admin page",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) => QuestionForm(),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Setting ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
