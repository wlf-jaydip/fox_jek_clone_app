import 'package:flutter/material.dart';
import 'package:staging_fox_jek_clone_app/constants/size_constants.dart';
import 'package:staging_fox_jek_clone_app/screen/homeScreen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      builder: (context, child) {
        deviceWidth = MediaQuery.sizeOf(context).width;
        deviceHeight = MediaQuery.sizeOf(context).height;
        averageSize = (deviceWidth * deviceHeight) / 2;
        return child!;
      },
      home: HomeScreen(),
    );
  }
}
