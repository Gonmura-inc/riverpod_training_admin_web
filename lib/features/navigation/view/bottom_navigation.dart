import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training_admin/config/utils/enum/router_enum.dart';
import 'package:riverpod_training_admin/routing/app_router.dart';

class BottomNavigation extends HookConsumerWidget {
  const BottomNavigation({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    useEffect(() {
      //現在のパス取得
      final String currentPath = ref.read(goRouterProvider).location;
      if (currentPath.startsWith(AppRoute.news.path)) {
        selectedIndex.value = AppRoute.news.currentIndex;
      }
      return null;
    }, [
      /// ここに変更を監視したい変数を入れる
      ref.watch(goRouterProvider).location,
    ]);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex.value,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '会員一覧',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'マイページ',
          ),
        ],
        onTap: (int value) {
          selectedIndex.value = value;
          // ref.read(bottomNaviSelectedIndexProvider.notifier).change(value);
          switch (value) {
            case 0:
              context.goNamed(AppRoute.news.name);
              break;
          }
        },
      ),
    );
  }
}
