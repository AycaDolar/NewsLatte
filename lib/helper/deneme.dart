import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsLatte/helper/txtController.dart';
import 'package:provider/provider.dart';

class Deneme extends StatefulWidget {
  const Deneme({Key? key}) : super(key: key);

  @override
  _DenemeState createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: ChangeNotifierProvider(
            create: (BuildContext context) {
              return TxtControllers();
            },
            child: Text(
              "Successfully Logged In\n Welcome ${Provider.of<TxtControllers>(context).usernameController.text}",
              style:
                  const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          )),
          ElevatedButton(
              onPressed: () async {
                await auth.signOut();
                Navigator.pop(context);
              },
              child: const Text("Sign out!"))
        ],
      ),
    );
  }
}
