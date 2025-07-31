import 'package:flutter/material.dart';

/// navigate to one screen to other screen
navigateToPush(BuildContext context, Widget route) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => route),
  );
}

/// navigate to one screen to other screen but not back to screen
navigateToPushReplacements(BuildContext context, Widget route) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => route),
  );
}

/// navigate to one screen to other screen but not back to screen
navigateToPushAndRemoveUntil(BuildContext context, Widget route) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => route),
    (route) => false,
  );
}
