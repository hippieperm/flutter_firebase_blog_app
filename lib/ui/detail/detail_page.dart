import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          iconButton(
            Icons.delete,
            () {},
          ),
          iconButton(
            Icons.edit,
            () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.network(
            'https://picsum.photos/200/300',
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '아이 런드',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 14),
                const Text(
                  '이인혁',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  '2024.8.8 20:30',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                ),
                const SizedBox(height: 14),
                Text(
                  '플러터의 그리드 뷰를 배웠습니다' * 10,
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
