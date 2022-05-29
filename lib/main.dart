import 'dart:async';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsLatte/helper/txtController.dart';
import 'package:newsLatte/helper/widgets.dart';
import 'package:newsLatte/login_main.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  AwesomeNotifications().initialize(
    '',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.purple,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => TxtControllers(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Latte',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginProcess(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFAA0BFF),
                Color(0xFFA31FB4),
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                assetName,
                width: 300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}
