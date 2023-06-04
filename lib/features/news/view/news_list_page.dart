import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training_admin/common_widget/custom_data_table.dart';
import 'package:riverpod_training_admin/features/news/view/row_source.dart';
import 'package:riverpod_training_admin/features/news/controller/news_controller.dart';
import 'package:riverpod_training_admin/features/news/data_model/news.dart';

import '../../../config/utils/enum/router_enum.dart';

class NewsListPage extends HookConsumerWidget {
  const NewsListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rowsPerPage = useState(10);
    final isSorted = useState(false);
    return Scaffold(
      appBar: AppBar(title: const Text("ニュース一覧")),
      body: ref.watch(newsStreamProvider(isSorted.value)).when(
          data: (List<News> newsList) {
        return Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            child: CustomDataTable(
              onRowsPerPageChanged: (page) {
                _onRowsPerPageChanged(ref, rowsPerPage, page);
              },
              rowsPerPage: rowsPerPage.value,
              dataSort: isSorted.value,
              sortDataColIndex: 1,
              columns: [
                const DataColumn(
                  label: Text("タイトル"),
                ),
                DataColumn(
                  label: const Text("作成日時"),
                  onSort: (columnIndex, ascending) {
                    isSorted.value = ascending;
                  },
                ),
              ],
              onPageChanged: (value) {},
              source: RowSourceNews(
                count: newsList.length,
                data: newsList,
                context: context,
              ),
            ),
          ),
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

  void _onRowsPerPageChanged(
    WidgetRef ref,
    ValueNotifier<int> rowsPerPage,
    int? page,
  ) {
    rowsPerPage.value = page!;
  }
}
