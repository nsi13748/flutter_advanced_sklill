import 'package:ch1_basic_ui/common/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    required this.onChanged,
    super.key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      )
    );

    return TextFormField(
      // 비밀번호 입력할때 사용
      obscureText: obscureText,
      // 이 화면에 올때 자동으로 포커싱
      autofocus: autofocus,
      // 값이 바뀔때마다 실행되는 콜백
      onChanged: onChanged,
      cursorColor: PRIMARY_COLOR,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14,
        ),
        fillColor: INPUT_BG_COLOR,
        filled: true,

        // 모든 Input 상태의 기본 스타일 세팅
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          )
        )
      ),
    );
  }
}
