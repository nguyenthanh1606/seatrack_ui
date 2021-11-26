import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/_controller.dart';
import 'package:seatrack_ui/src/core/services/local_storage_locale.dart';

import 'package:flutter/material.dart';
import 'package:seatrack_ui/src/core/services/local_storage_map.dart';
import 'package:settings_ui/settings_ui.dart';

import 'widgets/languages_screen.dart';
import 'widgets/map_type_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  final locales = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'Vietnamese', 'locale': Locale('vi', 'VN')},
  ];
  late String lang = '', mapName = '';
  Future<void> asyncGetLangIndex() async {
    mapName = await getMap();
    Locale? locale = await getLocale();
    List rs = locales.where((element) => element['locale'] == locale).toList();
    lang = rs[0]['name'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: asyncGetLangIndex(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(title: Text('setting'.tr), centerTitle: true),
            body: buildSettingsList(),
          );
        });
  }

  Widget buildSettingsList() {
    return SettingsList(
      contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 16),
      sections: [
        SettingsSection(
          title: 'common'.tr,
          tiles: [
            SettingsTile(
              title: 'language'.tr,
              subtitle: lang,
              leading: Icon(Icons.language),
              onPressed: (context) {
                // Get.to((context) => LanguagesScreen);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => LanguagesScreen(),
                ));
              },
            ),
            SettingsTile(
              title: 'map'.tr,
              subtitle: mapName,
              leading: Icon(Icons.cloud_queue),
              onPressed: (context) {
                // Get.to((context) => LanguagesScreen);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MapTypePage(),
                ));
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'account'.tr,
          tiles: [
            SettingsTile(
                title: 'username'.tr,
                subtitle: 'anhbay',
                leading: Icon(Icons.person)),
            SettingsTile(
                title: 'phoneNumber'.tr,
                subtitle: '0123222211',
                leading: Icon(Icons.phone)),
            SettingsTile(
                title: 'Email',
                subtitle: 'anhbay@gmail.com',
                leading: Icon(Icons.email)),
            SettingsTile(
                title: 'signOut'.tr,
                leading: Icon(Icons.exit_to_app),
                onPressed: (context) {
                  Get.find<AuthController>().signOut();
                }),
          ],
        ),
        SettingsSection(
          title: 'security'.tr,
          tiles: [
            SettingsTile.switchTile(
              title: 'lockAppInBackground'.tr,
              leading: Icon(Icons.phonelink_lock),
              switchValue: lockInBackground,
              onToggle: (bool value) {
                setState(() {
                  lockInBackground = value;
                  notificationsEnabled = value;
                });
              },
            ),
            SettingsTile.switchTile(
              title: 'useFingerprint'.tr,
              subtitle: 'allowApplicationToAccessStoredFingerprint'.tr,
              leading: Icon(Icons.fingerprint),
              onToggle: (bool value) {},
              switchValue: false,
            ),
            SettingsTile.switchTile(
              title: 'changePassword'.tr,
              leading: Icon(Icons.lock),
              switchValue: true,
              onToggle: (bool value) {},
            ),
            SettingsTile.switchTile(
              title: 'enableNotifications'.tr,
              enabled: notificationsEnabled,
              leading: Icon(Icons.notifications_active),
              switchValue: true,
              onToggle: (value) {},
            ),
          ],
        ),
        SettingsSection(
          title: 'Misc',
          tiles: [
            SettingsTile(
                title: 'Terms of Service', leading: Icon(Icons.description)),
            SettingsTile(
                title: 'Open source licenses',
                leading: Icon(Icons.collections_bookmark)),
          ],
        ),
      ],
    );
  }
}
