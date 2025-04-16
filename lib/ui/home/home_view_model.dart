import '../../data/model/post.dart';
import '../../data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends Notifier<List<Post>> {
  List<Post> posts = [];

  @override
  List<Post> build() {
    getAllPosts();
    return [];
  }

  Future<void> getAllPosts() async {
    // final posts = await PostRepository().getAll();
    // state = posts ?? [];

    final stream = PostRepository().postListStream();
    final streamSubscription = stream.listen((posts) {
      state = posts;
    });
    // 이 뷰모델이 없어질때 넘겨준 함수 호출
    ref.onDispose(() {
      // 구독 취소
      streamSubscription.cancel();
    });
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, List<Post>>(
  () => HomeViewModel(),
);
