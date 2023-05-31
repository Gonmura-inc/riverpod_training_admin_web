import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training_admin/features/news/data_model/news.dart';
import 'package:riverpod_training_admin/features/news/repo/news_repo.dart';

part 'news_controller.g.dart';

@riverpod
class NewsController extends _$NewsController {
  @override
  build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<News> getNews(String newsId) async {
    state = const AsyncLoading();
    //return await ref.read(NewsRepoProvider.notifier).getNews(NewsId);
    state = await AsyncValue.guard(
        () => ref.read(newsRepoProvider.notifier).getNews(newsId));
    return state.value;
  }

  //ドキュメント更新
  Future<void> updateNews(News updateNewsData) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(newsRepoProvider.notifier).updateNews(updateNewsData));
  }

  //ドキュメント削除
  Future<void> deleteNews(String newsId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(newsRepoProvider.notifier).deleteNews(newsId));
  }

  //ドキュメント追加
  Future<void> addNews(News addNewsData) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(newsRepoProvider.notifier).addNews(addNewsData));
  }
}

@riverpod
Stream<List<News>> newsStream(NewsStreamRef ref) {
  return ref.read(newsRepoProvider.notifier).watchNewsList();
}

@riverpod
Stream<News> watchNews(WatchNewsRef ref, String newsId) {
  return ref.read(newsRepoProvider).doc(newsId).snapshots().map(
        (DocumentSnapshot<News> snapshot) => snapshot.data()!,
      );
}
