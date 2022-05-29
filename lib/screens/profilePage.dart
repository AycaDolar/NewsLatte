import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:newsLatte/screens/signUpPage.dart';

import '../helper/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String location = 'Null, Press Button';
  String Address = '';
  bool isObscurePassword = true;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

  Future<NewsUser?> readUser() async {
    var name = FirebaseFirestore.instance
        .collection('newsUser')
        .doc(FirebaseAuth.instance.currentUser?.email);
    var snapshot = await name.get();
    if (snapshot.exists) {
      return NewsUser.fromJson(snapshot.data()!);
    }
  }

  Future<void> locato() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }

  @override
  Widget build(BuildContext context) {
    locato();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile '),
        backgroundColor: Colors.purple,
        leading: const BackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: Catlogo(context),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [

              const SizedBox(
                height: 30,
              ),
              FutureBuilder<NewsUser?>(
                  future: readUser(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Text("...");}
                    else if(snapshot.hasData){
                      final user=snapshot.data;
                      return user==null?Center(child: Text("",)):buildUserNameTextField(user,"Full Name" ,"", false);
                    }else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
              ),
              FutureBuilder<NewsUser?>(
                  future: readUser(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Someth");}
                    else if(snapshot.hasData){
                      final user=snapshot.data;
                      return user==null?Center(child: Text("",)):buildEmailTextField(user,"Email" ,"", false);
                    }else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
              ),
              Address==''?Center(child: CircularProgressIndicator()):buildTextField("Location", Address, false),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
                  onPressed: () {})
              : null,
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
    );
  }
}
Widget buildUserNameTextField(NewsUser user,
    String labelText, String placeholder, bool isPasswordTextField) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextField(
      obscureText: isPasswordTextField,
      decoration: InputDecoration(
        suffixIcon: isPasswordTextField
            ? IconButton(
            icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
            onPressed: () {})
            : null,
        contentPadding: const EdgeInsets.only(bottom: 5),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: user.username,
        hintStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    ),
  );
}
Widget buildEmailTextField(NewsUser user,
    String labelText, String placeholder, bool isPasswordTextField) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextField(
      obscureText: isPasswordTextField,
      decoration: InputDecoration(
        suffixIcon: isPasswordTextField
            ? IconButton(
            icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
            onPressed: () {})
            : null,
        contentPadding: const EdgeInsets.only(bottom: 5),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: user.email,
        hintStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    ),
  );
}
