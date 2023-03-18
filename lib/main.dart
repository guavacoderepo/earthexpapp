// ignore_for_file: deprecated_member_use
import 'package:earthexpapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


// void main() => runApp(const );

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBluquHd9qy3hINtPbVFL59zoP0QSTWHig", // Your apiKey
      appId: "1:689661273636:android:42ed7cfb8ae7e5d01e1ab1", // Your appId
      messagingSenderId: "689661273636", // Your messagingSenderId
      projectId: "earthexp-8259f",
      // storageBucket: "gs://earthexp-8259f.appspot.com", 
    )
  );
  // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    // showPerformanceOverlay: false,
    title: 'EarthExp',
    theme: ThemeData(fontFamily: 'GoogleFont'),
    // home: const register(),
    home: const Login(),
// Routes defined here
  ),
  );
}