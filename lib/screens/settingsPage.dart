import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:newsLatte/login_main.dart';
import 'package:newsLatte/screens/profilePage.dart';

import '../helper/widgets.dart';
import 'languagesScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

  String? email = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Settings'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 7.0),
              child: Catlogo(context),
            ),
          ],
        ),
        drawer: MyDrawer(context),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
          ),
          child: SettingsList(
            backgroundColor: Colors.white,
            sections: [
              SettingsSection(
                title: 'Common',
                tiles: [
                  SettingsTile(
                    title: 'Language',
                    subtitle: 'English',
                    leading: const Icon(Icons.language),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              LanguagesScreen()));
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'Account',
                tiles: [
                  SettingsTile(
                      title: 'Phone number', leading: const Icon(Icons.phone)),
                  SettingsTile(
                      title: "E-mail",
                      subtitle: email,
                      leading: const Icon(Icons.email)),
                  SettingsTile(
                    title: 'Profile',
                    leading: const Icon(Icons.account_circle_rounded),
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                    },
                  ),
                  SettingsTile(
                    title: 'Sign out',
                    leading: const Icon(Icons.exit_to_app),
                    onTap: () async {
                      logout(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginProcess()));
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'Security',
                tiles: [
                  SettingsTile.switchTile(
                    title: 'Change password',
                    leading: const Icon(Icons.lock),
                    switchValue: true,
                    onToggle: (bool value) {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
