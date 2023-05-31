import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training_admin/common_widget/news_list_tile.dart';
import 'package:riverpod_training_admin/features/news/controller/news_controller.dart';
import 'package:riverpod_training_admin/features/news/data_model/news.dart';

import '../../../config/utils/enum/router_enum.dart';

class NewsListPage extends ConsumerWidget {
  const NewsListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("ニュース一覧")),
      body: ref.watch(newsStreamProvider).when(data: (List<News> newsList) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final News newsData = newsList[index];
            return NewsListTile(newsData: newsData);
          },
          separatorBuilder: (context, index) => const Divider(height: 0.5),
          itemCount: newsList.length,
        );
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }, error: (error, stackTrace) {
        return const Center(child: Text('エラーだよ'));
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.goNamed(AppRoute.addNews.name);
        },
      ),
    );
  }
}
