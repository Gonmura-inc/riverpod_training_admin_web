import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training_admin/config/utils/enum/router_enum.dart';
import 'package:riverpod_training_admin/routing/app_router.dart';

class SideNavigation extends HookConsumerWidget {
  final Widget child;
  const SideNavigation({super.key, required this.child});
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
      appBar: AppBar(
        title: const Text("riverpod-training管理画面"),
        centerTitle: true,
        actions: const [],
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            // leading: Column(
            //   children: [
            //     const SizedBox(height: 10),
            //     const Text(
            //       "管理者ユーザー",
            //     ),
            //     const SizedBox(height: 10),
            //     Text(
            //       currentUser.email,
            //     ),
            //     const SizedBox(height: 10),
            //   ],
            // ),
            extended: true,
            selectedIndex: selectedIndex.value,
            onDestinationSelected: (int value) async {
              selectedIndex.value = value;
              switch (value) {
                case 0:
                  context.goNamed(AppRoute.news.name);
                  break;
              }
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.request_page),
                label: Text("ニュース一覧"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.request_page),
                label: Text("ニュース一覧"),
              ),
            ],
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
