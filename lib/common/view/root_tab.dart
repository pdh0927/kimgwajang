import 'package:flutter/material.dart';
import 'package:kimgwajang/complaint/view/complaint_list_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController
      controller; // late : 나중에 무조건 null이 아니라 controller 사용전에 세팅 한다

  int index = 0;

  @override
  void initState() {
    super.initState();
    // length : 몇 개 탭 사용할건지, vsync : 현재의  state 넣어주면 됨(그런데 SingleTickerProviderStateMixin이라는 기능 가지고 있어야함)
    controller = TabController(length: 2, vsync: this);
    controller.addListener(
        tabListener); // controller의 변경사항이 감지될 때마다 tabListener 함수 실행
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            controller
                .animateTo((index)); // 현재 탭과 인덱스가 다를 경우, 애니메이션을 사용하여 탭을 부드럽게 전환
          },
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: '민원')
          ]),
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(), // scroll로는 화면 전환 x
          controller: controller,
          children: const [
            ComplaintListScreen(),
            Center(child: Text('관공서')),
          ]),
    );
  }
}
