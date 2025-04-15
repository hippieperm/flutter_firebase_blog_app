import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';

class PostRepository {
  Future<List<Post>?> getAll() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('posts');
      final result = await collectionRef.get();

      final docs = result.docs;

      return docs.map((doc) {
        final map = doc.data();
        final newMap = {
          'id': doc.id,
          ...map,
        };
        return Post.fromJson(newMap);
      }).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> insert({
    required String title,
    required String content,
    required String writer,
    required String imageUrl,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('posts');
      final docRef = collectionRef.doc();
      await docRef.set({
        'id': docRef.id,
        'title': title,
        'content': content,
        'writer': writer,
        'imageUrl': imageUrl,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
