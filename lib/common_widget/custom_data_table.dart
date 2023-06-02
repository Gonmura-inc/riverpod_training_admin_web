import 'package:flutter/material.dart';

class CustomDataTable extends StatelessWidget {
  // final ScrollController scrollController;
  final int rowsPerPage;
  final bool dataSort;
  final int sortDataColIndex;
  final List<DataColumn> columns;
  final ValueChanged<int?>? onRowsPerPageChanged;
  final ValueChanged<int> onPageChanged;
  final DataTableSource source;
  //optional
  final double? headingRowHeight;
  final double? dataRowHeight;
  final int? initialFirstRowIndex;
  const CustomDataTable({
    super.key,
    required this.rowsPerPage,
    required this.dataSort,
    required this.sortDataColIndex,
    required this.columns,
    this.onRowsPerPageChanged,
    required this.onPageChanged,
    required this.source,
    this.headingRowHeight,
    this.dataRowHeight,
    this.initialFirstRowIndex,
  });

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      onRowsPerPageChanged: onRowsPerPageChanged,
      onPageChanged: onPageChanged,
      headingRowHeight: headingRowHeight ?? 90,
      showFirstLastButtons: true,
      rowsPerPage: rowsPerPage,
      availableRowsPerPage: const [10, 30, 50],
      initialFirstRowIndex: initialFirstRowIndex ?? 0,
      sortColumnIndex: sortDataColIndex,
      sortAscending: dataSort,
      source: source,
      columnSpacing: 48.0,
      columns: columns,
    );
  }
}
