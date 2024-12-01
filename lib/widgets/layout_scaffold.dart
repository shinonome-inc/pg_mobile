import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/constants/app_colors.dart';

/// GoRouterを用いてBottomNavigationBarのitemを表示するためのWidget。
class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  /// 動的にアイコンを生成する。
  ///
  /// [currentIndex]が選択されているアイテムのindex。
  ///
  /// アイテムが選択されている場合はアイコンをfilledに、選択されていない場合はoutlinedにする。
  List<BottomNavigationBarItem> _buildItems(int currentIndex) {
    return [
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined),
        label: 'タイムライン',
      ),
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 1
            ? Icons.notifications
            : Icons.notifications_outlined),
        label: '通知',
      ),
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 2 ? Icons.person : Icons.person_outline),
        label: 'マイページ',
      ),
      BottomNavigationBarItem(
        icon:
            Icon(currentIndex == 3 ? Icons.settings : Icons.settings_outlined),
        label: '設定',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.gray2,
        unselectedItemColor: AppColors.gray4,
        selectedItemColor: AppColors.accent,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        items: _buildItems(navigationShell.currentIndex),
      ),
    );
  }
}
