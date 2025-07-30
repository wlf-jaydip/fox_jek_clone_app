import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/size_constants.dart';
import 'screen/homeScreen/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First Method',
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
        ),
      ),
      darkTheme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
      builder: (context, child) {
        deviceWidth = MediaQuery.sizeOf(context).width;
        deviceHeight = MediaQuery.sizeOf(context).height;
        averageSize = (deviceWidth + deviceHeight) / 2;
        return child!;
      },
      home: HomeScreen(),
    );
  }
}
