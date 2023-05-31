import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training_admin/config/utils/enum/router_enum.dart';
import 'package:riverpod_training_admin/config/utils/margin/height_margin.dart';
import 'package:riverpod_training_admin/features/news/controller/news_controller.dart';
import 'package:riverpod_training_admin/features/news/data_model/news.dart';
import 'package:riverpod_training_admin/functions/show_snack_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class AddOrEditNewsPage extends HookConsumerWidget {
  const AddOrEditNewsPage({super.key, this.newsId});
  final String? newsId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController newsTitleController =
        useTextEditingController();
    late News newsData;
    Future(() async {
      if (newsId != null) {
        newsData =
            await ref.read(newsControllerProvider.notifier).getNews(newsId!);
        newsTitleController.text = newsData.title;
      }
    });
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text(newsId == null ? "ニュースを作成" : 'ニュースを編集')),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                //ニュースのタイトルを入れるフォーム
                TextFormField(
                  controller: newsTitleController,
                  validator: (value) {
                    if (value == "") {
                      return "必須入力項目です";
                    }
                    return null;
                  },
                ),
                HeightMargin.normal,
                //ニュース追加ボタン
                ElevatedButton(
                  onPressed: () {
                    //ニュースを作る処理（ロジック）はview(見た目)とは関係がないので、
                    //メソッドを作成して見た目に関わるコードから分離するのが良い
                    //_(アンダースコア)をつけて関数名を定義し、
                    //関数にカーソルを当てた状態でcmd+.を押し、create methodという候補を選択
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    if (newsId == null) {
                      _createNews(
                        context: context,
                        ref: ref,
                        textEditingController: newsTitleController,
                      );
                    } else {
                      //ニュースを編集する処理
                      _editNews(
                        context: context,
                        ref: ref,
                        newsTitleController: newsTitleController,
                        newsData: newsData,
                      );
                    }
                  },
                  child: Text(newsId == null ? 'ニュースを作成' : 'ニュースを編集'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createNews({
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController textEditingController,
  }) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      okLabel: 'OK',
      cancelLabel: 'キャンセル',
      title: 'ニュースの追加',
      message: 'ニュースを追加しても良いですか？',
    );
    if (result == OkCancelResult.ok) {
      try {
        News newsToAdd = News(
          newsId: const Uuid().v4(),
          title: textEditingController.text,
          createdAt: Timestamp.now(),
        );
        await ref.read(newsControllerProvider.notifier).addNews(newsToAdd);
        if (context.mounted) {
          context.goNamed(AppRoute.news.name);
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, e.toString());
      }
    }
  }

  void _editNews({
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController newsTitleController,
    required News newsData,
  }) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      okLabel: 'OK',
      cancelLabel: 'キャンセル',
      title: 'ニュースの更新',
      message: 'ニュースを更新しても良いですか？',
    );
    if (result == OkCancelResult.ok) {
      try {
        final News editNewsData = newsData.copyWith(
          title: newsTitleController.text,
        );
        await ref
            .read(newsControllerProvider.notifier)
            .updateNews(editNewsData);
        if (context.mounted) {
          context.goNamed(AppRoute.news.name);
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, e.toString());
      }
    }
  }
}
