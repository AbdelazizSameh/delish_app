import 'package:delish/Services/firebase/firebase_options.dart';
import 'package:delish/utils/app_assets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screens/welcome_page/welcome_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const DelishApp());
}

class DelishApp extends StatelessWidget {
  const DelishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: AppAssets.appFont,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarThemeData(backgroundColor: Colors.white),
          ),
          home: const WelcomeView(),
        );
      },
    );
  }
}
