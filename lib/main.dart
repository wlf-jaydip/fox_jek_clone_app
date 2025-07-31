import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staging_fox_jek_clone_app/screen/selectionScreen/selection_screen.dart';

import 'constants/size_constants.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First Method',
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      darkTheme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      builder: (context, child) {
        deviceWidth = MediaQuery.of(context).size.width;
        deviceHeight = MediaQuery.of(context).size.height;
        averageSize = (deviceWidth + deviceHeight) / 2;
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: child!,
        );
      },
      home: SelectionScreen(),
    );
  }
}
