import 'package:flutter/material.dart';

class Navigation {
  static goTo(BuildContext context, Widget route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  static goAndReplace(BuildContext context, Widget route) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => route),
        (Route<dynamic> route) => false);
  }
  static pop(context) {
    Navigator.pop(context);
  }
}
