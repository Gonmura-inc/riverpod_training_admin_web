import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training_admin/config/utils/enum/router_enum.dart';
import 'package:riverpod_training_admin/features/news/data_model/news.dart';

class NewsListTile extends ConsumerWidget {
  final News newsData;
  const NewsListTile({super.key, required this.newsData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            context.goNamed(
              AppRoute.editNews.name,
              queryParameters: {
                "newsId": newsData.newsId,
              },
            );
          },
          title: Text(newsData.title),
        ),
      ],
    );
  }
}
