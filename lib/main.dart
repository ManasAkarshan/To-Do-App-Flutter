import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/pages/home_page.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey[900]!,
    secondary: Colors.grey[800]!
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black
  )
);

void main() async{
  // init the hive
  await Hive.initFlutter();

  //Open the box
  var box = await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const HomePage(),
    );
  }
}


