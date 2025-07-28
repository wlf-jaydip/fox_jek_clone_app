import 'package:flutter/material.dart';

navigateToPush(BuildContext context, Widget route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => route));
}

navigateToPushReplacements(BuildContext context, Widget route) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => route));
}
