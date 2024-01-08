import 'package:flutter/material.dart';
import 'HomePageContent.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( scaffoldBackgroundColor: Colors.blueGrey,
        textTheme: TextTheme( bodyMedium: TextStyle(color: Colors.white) ),
        appBarTheme: AppBarTheme( backgroundColor: Colors.black, iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          elevation: 3.0, shadowColor: Colors.white,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15) ),
        ),
      ),
      home: HomePage(),
    );
  }
}



