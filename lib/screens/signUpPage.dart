import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsLatte/helper/txtController.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference newsUserRef = _fireStore.collection('newsUser');

    TextEditingController _emailController =
        Provider.of<TxtControllers>(context).emailController;
    TextEditingController _passwordController =
        Provider.of<TxtControllers>(context).passwordController;
    TextEditingController _usernameController =
        Provider.of<TxtControllers>(context).usernameController;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffB2F9FC),
                  Color(0xff091353),
                ]),
          ),
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 10.0,
                left: 30.0,
                right: 30.0,
                child: SvgPicture.asset(
                  "assets/icons/signup.svg",
                  width: size.width * 0.43,
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                child: Image.asset("assets/images/signup_top.png"),
                width: size.width * 0.3,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                child: Image.asset("assets/images/main_bottom.png"),
                width: size.width * 0.25,
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Image.asset("assets/images/login_bottom.png"),
                width: size.width * 0.3,
              ),
              /////////////////////////////////////
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 89.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17.0, vertical: 5.0),
                    child: TextFormField(
                      controller: Provider.of<TxtControllers>(context)
                          .usernameController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.purple,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          labelText: "Username",
                          labelStyle: TextStyle(color: Colors.purple)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17.0, vertical: 5.0),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.purple,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          labelText: "E-Mail",
                          labelStyle: TextStyle(color: Colors.purple)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17.0, vertical: 5.0),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.purple,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.purple)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already a member?"),
                      TextButton(
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    width: 150.0,
                    child: ElevatedButton(
                      child: const Text("Sign Up"),
                      onPressed: () async {
                        createUserWithEmailPS(
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context);

                        Map<String, dynamic> newsUserData = {
                          'username': _usernameController.text,
                          'email': _emailController.text,
                          'password': _passwordController.text
                        };
                        await newsUserRef
                            .doc(_emailController.text)
                            .set(newsUserData);
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5.0),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17.0),
                                      side: const BorderSide(
                                          color: Colors.purple)))),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

Future<User?> createUserWithEmailPS(
    {required String email,
    required String password,
    required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    user = userCredential.user;
    print(userCredential.user?.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-fount") {
      print("Error");
    }
  }
  return user;
}

class NewsUser {
  String username;
  String email;
  String password;

  NewsUser(
      {required this.username, required this.email, required this.password});

  static NewsUser fromJson(Map<String, dynamic> json) {
    return NewsUser(
      email: json['email'],
      password: json['password'],
      username: json['username'],
    );
  }
}
