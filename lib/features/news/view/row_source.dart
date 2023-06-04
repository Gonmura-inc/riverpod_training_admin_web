import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_training_admin/config/utils/enum/router_enum.dart';
import 'package:riverpod_training_admin/features/news/data_model/news.dart';

class RowSourceNews extends DataTableSource {
  final List<News> data;
  final int count;
  final BuildContext context;
  RowSourceNews({
    required this.data,
    required this.count,
    required this.context,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(data[index], context);
    } else {
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRow(News data, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(InkWell(
          onTap: () {
            context.goNamed(AppRoute.editNews.name, queryParameters: {
              'newsId': data.newsId,
            });
          },
          child: Text(
            data.title,
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ))),
      DataCell(Text(data.createdAt.toDate().toString().substring(0, 16))),
    ],
  );
}
