import 'package:flutter/material.dart';
import 'package:riverpod_training_admin/features/news/data_model/news.dart';

class RowSourceNews extends DataTableSource {
  final List<News> data;
  final int count;
  RowSourceNews({
    required this.data,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(data[index]);
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

DataRow recentFileDataRow(News data) {
  return DataRow(
    cells: [
      DataCell(Text(data.title)),
      DataCell(Text(data.createdAt.toDate().toString().substring(0, 16))),
    ],
  );
}
