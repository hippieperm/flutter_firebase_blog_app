import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import '../../data/model/post.dart';
import '../../data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class WriteState {
  bool isWriting;
  String? imageUrl;

  WriteState(
    this.isWriting,
    this.imageUrl,
  );
}

class WriteViewModel extends AutoDisposeFamilyNotifier<WriteState, Post?> {
  WriteState build(Post? arg) {
    return WriteState(false, arg?.imageUrl);
  }

  Future<bool> insert({
    required String writer,
    required String title,
    required String content,
  }) async {
    if (state.imageUrl == null) {
      return false;
    }

    final postRepository = PostRepository();

    state = WriteState(true, state.imageUrl);
    if (arg == null) {
      final result = await postRepository.insert(
        writer: writer,
        title: title,
        content: content,
        imageUrl: state.imageUrl!,
      );
      await Future.delayed(Duration(milliseconds: 500));
      state = WriteState(false, state.imageUrl);
      return result;
    } else {
      final result = await postRepository.update(
        id: arg!.id,
        writer: writer,
        title: title,
        content: content,
        imageUrl: state.imageUrl!,
      );
      await Future.delayed(Duration(milliseconds: 500));
      state = WriteState(false, state.imageUrl);
      return result;
    }
  }

  void uploadImage(XFile xFile) async {
    try {
      // Firebase Storage 사용법
      // 1. FirebaseStorage 객체 가지고 오기
      final storage = FirebaseStorage.instance;
      // 2. 스토리지 참조 만들기
      Reference ref = storage.ref();
      // 3. 파일 참조 만들기
      Reference fileRef =
          ref.child('${DateTime.now().microsecondsSinceEpoch}_${xFile.name}');
      // 4. 쓰기!
      await fileRef.putFile(File(xFile.path));
      // 5. 파일에 접근할 수 있는 URL 받기
      String imageUrl = await fileRef.getDownloadURL();
      state = WriteState(false, imageUrl);
    } catch (e) {
      print(e);
    }
  }
}

final writeViewModelProvider =
    NotifierProvider.autoDispose.family<WriteViewModel, WriteState, Post?>(
  () => WriteViewModel(),
);
