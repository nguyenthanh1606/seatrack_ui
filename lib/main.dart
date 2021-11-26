import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'src/helper/binding.dart';
import 'src/core/services/local_storage_locale.dart';
import 'src/resources/language_translations.dart';
import 'src/views/pages/control_page.dart';
import 'src/views/themes/app_theme.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await dotenv.load(
    fileName: ".env",
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Future<void> didChangeDependencies() async {
    await getLocale().then((locale) {
      setState(() {
        Get.updateLocale(locale);
      });
    });
    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => ScreenUtilInit(
        designSize: orientation == Orientation.portrait
            ? const Size(375, 812)
            : const Size(812, 375),
        builder: () => GetMaterialApp(
          translations: LanguageTranslations(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          initialBinding: Binding(),
          // theme: AppTheme.light,
          // darkTheme: AppTheme.dark,
          // themeMode: ThemeMode.system,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ControlPage(),
          debugShowCheckedModeBanner: false,
          title: 'Seatrack KHN',
        ),
      ),
    );
  }
}
