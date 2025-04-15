import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepository {
  Future<void> getAll() async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('posts');
    final result = await collectionRef.get();

    final docs = result.docs;

    for (var doc in docs) {
      print(doc.id);
    }
  }
}
