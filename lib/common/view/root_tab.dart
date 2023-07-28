import 'package:ch1_basic_ui/common/const/colors.dart';
import 'package:ch1_basic_ui/common/layout/default_layout.dart';
import 'package:ch1_basic_ui/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;    // ? 를 붙여도 되지만, late키워드를 사용하면 나중에 무조건 선언할꺼야라는걸 알려준다. ?를 하면 계속 null처리를 해줘야해서 귀찮음

  int index = 0;

  @override
  void initState() {
    super.initState();
    
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);

  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
}


  @override
  void dispose() {

    controller.removeListener(tabListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        // 컨트롤러 생성
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          RestaurantScreen(),
          Center(child: Container(child: Text('음식'),)),
          Center(child: Container(child: Text('주문'),)),
          Center(child: Container(child: Text('프로필'),)),
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        // 선택된 탭이 더 크게 표시댐
        onTap: (int index) {
          setState(() {
            // controller.animateTo 에게 인덱스를 전달하면 화면 전환
            controller.animateTo(index);
          });
        },
        currentIndex: index,
      ),
    );
  }
}
