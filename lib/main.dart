import 'package:flutter/material.dart';
import 'screens/material_list_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Granites App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MaterialListScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
