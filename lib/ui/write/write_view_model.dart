import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WriteState {
  bool isWriting;

  WriteState(
    this.isWriting,
  );
}

class WriteViewModel extends AutoDisposeFamilyNotifier<WriteState, Post?> {
  WriteState build(Post? arg) {
    return WriteState(false);
  }

  Future<bool> insert({
    required String writer,
    required String title,
    required String content,
  }) async {
    final postRepository = PostRepository();

    state = WriteState(true);
    if (arg == null) {
      final result = await postRepository.insert(
        writer: writer,
        title: title,
        content: content,
        imageUrl: 'https://picsum.photos/200/300',
      );
      await Future.delayed(Duration(milliseconds: 500));
      state = WriteState(false);
      return result;
    } else {
      final result = await postRepository.update(
        id: arg!.id,
        writer: writer,
        title: title,
        content: content,
        imageUrl: 'https://picsum.photos/200/300',
      );
      await Future.delayed(Duration(milliseconds: 500));
      state = WriteState(false);
      return result;
    }
  }
}

final writeViewModelProvider =
    NotifierProvider.autoDispose.family<WriteViewModel, WriteState, Post?>(
  () => WriteViewModel(),
);
