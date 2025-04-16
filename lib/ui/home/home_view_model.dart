import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends Notifier<List<Post>> {
  List<Post> posts = [];

  @override
  List<Post> build() {
    getAllPosts();
    return [];
  }

  Future<void> getAllPosts() async {
    final posts = await PostRepository().getAll();
    state = posts ?? [];
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, List<Post>>(
  () => HomeViewModel(),
);
