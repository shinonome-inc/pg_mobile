import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/home/home_view.dart';
import 'package:pg_mobile/notifications/notifications_view.dart';
import 'package:pg_mobile/office/office_view.dart';
import 'package:pg_mobile/rank/rank_view.dart';
import 'package:pg_mobile/user/user_view.dart';

enum NavigationMenu { home, notifications, office, rank, user }

final baseTabViewProvider =
    StateProvider<NavigationMenu>((ref) => NavigationMenu.home);

class BottomNavigation extends ConsumerWidget {
  BottomNavigation({super.key});

  final screens = [
    const HomeView(),
    const NotificationsView(),
    const OfficeView(),
    const RankView(),
    const UserView(),
  ];

  final bottomManuItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.notifications), label: 'Notifications'),
    const BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Office'),
    const BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Rank'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(baseTabViewProvider);
    return Scaffold(
      body: screens[view.index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomManuItems,
        currentIndex: view.index,
        onTap: (index) => ref.read(baseTabViewProvider.notifier).state =
            NavigationMenu.values[index],
      ),
    );
  }
}
