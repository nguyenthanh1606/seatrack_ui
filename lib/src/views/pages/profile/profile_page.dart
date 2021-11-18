import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/_controller.dart';
import 'package:seatrack_ui/src/core/services/local_storage_locale.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final locales = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'Vietnamese', 'locale': Locale('vi', 'VN')},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.find<AuthController>().signOut();
              },
              child: const Text('Log out'),
            ),
            ElevatedButton(
              child: Text(
                'button1'.tr,
              ),
              onPressed: () => {showLocaleDialog(context)},
            ),
          ],
        ),
      ),
    );
  }

  updateLocale(Locale locale, BuildContext context) {
    Navigator.of(context).pop();
    setLocale(locale.languageCode, locale.countryCode!);
    Get.updateLocale(locale);
  }

  showLocaleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('chooseLanguage'.tr),
        content: Container(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => InkWell(
              child: Padding(
                child: Text(locales[index]['name'].toString()),
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
              onTap: () => updateLocale(
                locales[index]['locale'] as Locale,
                context,
              ),
            ),
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
            itemCount: locales.length,
          ),
        ),
      ),
    );
  }
}
