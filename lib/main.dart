import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/services/local_storage_app.dart';
import 'package:seatrack_ui/src/views/widgets/Onboarding/onboarding.dart';
import 'package:seatrack_ui/src/views/widgets/splash_screen.dart';

import 'src/helper/binding.dart';
import 'src/core/services/local_storage_locale.dart';
import 'src/resources/language_translations.dart';
import 'src/views/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  bool shortScreen = await getScreenStart();

  runApp(MyApp(shortScreen: shortScreen));
}

class MyApp extends StatefulWidget {
  bool shortScreen;

  MyApp({Key? key, required this.shortScreen}) : super(key: key);

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
            // primaryColor: Color(0XFF9effff),
            primaryColor: Color(0XFF008e76),
            accentColor: Color(0XFF9effff),
            primarySwatch: Colors.teal,
          ),
          home: widget.shortScreen
              ? const Onboarding(screenHeight: 600)
              : const SplashScreen(),
          debugShowCheckedModeBanner: false,
          title: 'Seatrack KHN',
        ),
      ),
    );
  }
}
