import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/common/view/root_tab.dart';

void main() async {
  runApp(const ProviderScope(child: _App()));
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootTab(),
    );
  }
}
