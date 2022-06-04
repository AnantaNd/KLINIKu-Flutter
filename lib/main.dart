import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kliniku/const.dart';
import 'package:kliniku/firebase_options.dart';
import 'package:kliniku/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KLINIKu',
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(primary: primaryColor)),
      // home: isViewed != 0 ? OnBoard() : WelcomeScreen(),
      home: MainPage(),
    );
  }
}
