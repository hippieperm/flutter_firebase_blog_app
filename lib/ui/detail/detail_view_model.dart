import '../../data/model/post.dart';
import '../../data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailViewModel extends AutoDisposeFamilyNotifier<Post, Post> {
  @override
  Post build(Post post) {
    listenStream(post.id);
    return post;
  }

  Future<bool> delete(Post post) async {
    return await PostRepository().delete(post.id);
  }

  void listenStream(String id) {
    final stream = PostRepository().postStream(id);
    final streamSubscription = stream.listen((post) {
      if (post != null) {
        state = post;
      }
    });
    ref.onDispose(() {
      streamSubscription.cancel();
    });
  }
}

final detailViewModelProvider =
    NotifierProvider.autoDispose.family<DetailViewModel, Post, Post>(
  () => DetailViewModel(),
);
