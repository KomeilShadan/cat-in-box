import 'package:flutter/material.dart';
import 'screens/home.dart';

class App extends StatelessWidget 
{
  const App({Key? key}) : super(key: key);

  @override
  
  Widget build(context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Cat-in-Box',
      theme: ThemeData
      (
        primarySwatch: Colors.deepPurple
      ),
      home: const Home(),
    );
  }
}