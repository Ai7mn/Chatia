import 'package:flutter/material.dart';
import 'package:chatia/screens/auth_screen.dart';
import 'package:chatia/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Chat App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        backgroundColor: Colors.amber,
        accentColor: Colors.black54,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.amber,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges() ,
        builder: (ctx , snapshot) {
          if(snapshot.hasData){
            return MainScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
