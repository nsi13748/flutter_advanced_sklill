import 'package:ch1_basic_ui/common/const/colors.dart';
import 'package:ch1_basic_ui/common/const/data.dart';
import 'package:ch1_basic_ui/common/layout/default_layout.dart';
import 'package:ch1_basic_ui/common/view/root_tab.dart';
import 'package:ch1_basic_ui/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // initState 는 await가 안된다. -> 따라서 새로운 함수를 만들어야한다.
    checkToken();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
      return ; // 이렇게 하면 이 코드가 실행될 떄 아후의 코드 실행 X
    }

    final Dio dio = Dio();

    try {
      // refreshToken이 만료가 안된경우 -> statusCode 가 정상일 경우
      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(headers: {'authorization': 'Bearer $refreshToken'}),
      );
      storage.write(key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => RootTab()), (route) => false);
    } catch (e) {
      // refreshToken 이 만료 -> statusCode가 비정상일 경우 -> 로그인 화면
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    }
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 16,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
