import 'package:flutter/material.dart';

// 모든 뷰에서 공통적으로 적용하고 싶은 어떤 것이 있을때 꼭 필요함.
// 그래서 LoginScreen에서 공통적인 어떤 것을 넣고싶다고 하면, build 메서드의 return에 DefaultLayout으로 감싸준다.

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    super.key,
    this.backgroundColor,
    required this.child,
    this.title,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      // backgroundColor is null -> Colors.white
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
      );
    }
  }
}
