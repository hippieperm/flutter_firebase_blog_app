import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/ui/detail/detail_page.dart';
import 'package:flutter_firebase_blog_app/ui/home/home_view_model.dart';
import 'package:flutter_firebase_blog_app/ui/write/write_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.edit,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WritePage();
              },
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('BLOG'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('최근글', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, child) {
                final posts = ref.watch(homeViewModelProvider);
                return Expanded(
                  child: ListView.separated(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return item(post);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget item(Post post) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return DetailPage(post: post);
            },
          ));
        },
        child: SizedBox(
          width: double.infinity,
          height: 120,
          child: Stack(
            children: [
              Positioned(
                width: 120,
                height: 120,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    post.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(right: 100),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      post.content,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      post.createdAt.toIso8601String(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
