import 'package:flutter/material.dart';
import 'core/app_const.dart';
import 'core/theme.dart';
import 'helpers/service_locator.dart';
import 'pages/home_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: gTitleHome,
      theme: myTheme,
      home: HomePage(),
    );
  }
}
