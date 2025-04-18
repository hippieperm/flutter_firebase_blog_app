import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/post.dart';

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
        'createdAt': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Post?> getOne(String id) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('posts');
      final docRef = collectionRef.doc(id);
      final doc = await docRef.get();
      return Post.fromJson(
        {
          'id': doc.id,
          ...doc.data()!,
        },
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> update({
    required String id,
    required String writer,
    required String title,
    required String content,
    required String imageUrl,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('posts');
      final docRef = collectionRef.doc(id);
      await docRef.update({
        'writer': writer,
        'title': title,
        'content': content,
        'imageUrl': imageUrl,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete(String id) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('posts');
      final docRef = collectionRef.doc(id);
      await docRef.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<Post>> postListStream() {
    final firestore = FirebaseFirestore.instance;
    final collectionRef =
        firestore.collection('posts').orderBy('createdAt', descending: true);
    final stream = collectionRef.snapshots();

    final newStream = stream.map((event) {
      return event.docs.map((e) {
        return Post.fromJson({
          'id': e.id,
          ...e.data(),
        });
      }).toList();
    });

    return newStream;
  }

  Stream<Post?> postStream(String id) {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('posts');
    final docRef = collectionRef.doc(id);
    final stream = docRef.snapshots();

    final newStream = stream.map((e) {
      if (e.data() == null) {
        return null;
      }
      return Post.fromJson({
        'id': e.id,
        ...e.data()!,
      });
    });
    return newStream;
  }
}
