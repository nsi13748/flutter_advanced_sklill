import 'package:ch1_basic_ui/common/const/colors.dart';
import 'package:ch1_basic_ui/common/const/data.dart';
import 'package:ch1_basic_ui/common/layout/default_layout.dart';
import 'package:ch1_basic_ui/common/view/root_tab.dart';
import 'package:ch1_basic_ui/user/view/login_screen.dart';
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

    if(refreshToken == null || accessToken == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);

    } else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => RootTab()), (route) => false);
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
            Image.asset('asset/img/logo/logo.png',
            width: MediaQuery.of(context).size.width/2,
            ),
            const SizedBox(height: 16,),
            CircularProgressIndicator(
              color: Colors.white,
            )

          ],
        ),
      ),
    );
  }
}
