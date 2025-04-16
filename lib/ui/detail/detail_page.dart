import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/ui/detail/detail_view_model.dart';
import 'package:flutter_firebase_blog_app/ui/write/write_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  final Post post;

  const DetailPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detailViewModelProvider(post));

    return Scaffold(
      appBar: AppBar(
        actions: [
          iconButton(
            Icons.delete,
            () async {
              final result = await ref
                  .read(detailViewModelProvider(post).notifier)
                  .delete(post);
              if (result) {
                Navigator.pop(context);
              }
            },
          ),
          iconButton(
            Icons.edit,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WritePage(post: post);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 500),
        children: [
          Image.network(
            state.imageUrl,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 14),
                Text(
                  state.writer,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  state.createdAt.toIso8601String(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w200),
                ),
                const SizedBox(height: 14),
                Text(
                  state.content,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget iconButton(IconData icon, void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.transparent,
        child: Icon(icon),
      ),
    );
  }
}
