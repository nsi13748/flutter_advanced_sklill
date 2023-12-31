import 'dart:convert';
import 'dart:io';

import 'package:ch1_basic_ui/common/const/colors.dart';
import 'package:ch1_basic_ui/common/const/data.dart';
import 'package:ch1_basic_ui/common/layout/default_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/view/root_tab.dart';



/// 로그인 로직도 여기에 구현되어있음.
///

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? username = '';
  String? password = '';


  @override
  Widget build(BuildContext context) {
    final dio = Dio(); // API 통신을 위한 Dio 선언



    return DefaultLayout(
      child: SingleChildScrollView( // 키보드가 올라왔을때 오류나는걸 막아주는 방법
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // UI 꿀팁: 화면 스크롤 하면 키보드 넣어줌
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16,),
                _Title(),
                const SizedBox(height: 16,),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 3 * 2,
                ),
                CustomTextFormField(
                  onChanged: (String? value) {
                    username = value;
                  },
                  hintText: '이메일을 입력해주세요.',
                ),
                const SizedBox(height: 16,),
                CustomTextFormField(
                  onChanged: (String? value) {
                    password = value;
                  },
                  hintText: '비밀번호를 입력해주세요.',
                  obscureText: true,
                ),
                const SizedBox(height: 16,),

                /// 로그인 버튼
                ElevatedButton(
                  onPressed: () async {
                    final rawString = '$username:$password';    // 아이디와 비밀번호. -> base64로 인코딩하는법

                    Codec<String, String> stringToBase64 = utf8.fuse(base64); // 이거는 외워야함. 일반 String -> base64로 변경
                    String token = stringToBase64.encode(rawString);
                    print(ip);

                    final response = await dio.post('http://$ip/auth/login',
                      options: Options(
                          headers: {
                            'authorization' : 'Basic $token'
                          }
                      ),
                    );

                    print(response.data); // response.data = HTTP 의 body 부분을 Json형태로 응답

                    final refreshToken = response.data['refreshToken'];
                    final accessToke = response.data['accessToken'];

                    await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(key: ACCESS_TOKEN_KEY, value: accessToke);


                    // 오류가 나지 않았다면, 페이지 이동
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => RootTab(), ), );

                  },
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                  child: Text('로그인'),
                ),


                /// 회원가입 버튼
                TextButton(
                  onPressed: () async {

                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text('회원가입'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다.',
      style: TextStyle(
          fontSize: 34, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
