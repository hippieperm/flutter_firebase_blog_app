import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailViewModel extends AutoDisposeFamilyNotifier<Post, Post> {
  @override
  Post build(Post post) {
    return post;
  }

  Future<bool> delete(Post post) async {
    return await PostRepository().delete(post.id);
  }
}

final detailViewModelProvider =
    AutoDisposeFamilyNotifierProvider<DetailViewModel, Post, Post>(
  () => DetailViewModel(),
);
