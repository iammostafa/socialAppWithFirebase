import 'package:flutter/material.dart';
import 'package:social_app/features/chat/screens/chatScreen.dart';
import 'package:social_app/features/login/screens/login_screen.dart';
import 'package:social_app/features/main/screens/main_screen.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/chatScreen':
        return MaterialPageRoute(builder: (_) => ChatScreen());

      case '/loginScreen':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/':
        return MaterialPageRoute(builder: (_) => MainScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Erorr'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
