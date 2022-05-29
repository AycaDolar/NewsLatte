import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsLatte/screens/loginPage.dart';

class LoginProcess extends StatelessWidget {
  const LoginProcess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const DesignedHomeScreen();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}
