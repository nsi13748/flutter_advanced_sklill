import 'package:ch1_basic_ui/common/component/custom_text_form_field.dart';
import 'package:ch1_basic_ui/user/view/login_screen.dart';
import 'package:ch1_basic_ui/common/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
      home: SplashScreen(),
    );
  }
}
