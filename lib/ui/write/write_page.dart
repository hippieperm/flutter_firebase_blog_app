import 'package:flutter/material.dart';
import '../../data/model/post.dart';
import 'write_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class WritePage extends ConsumerStatefulWidget {
  Post? post;

  WritePage({super.key, this.post});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  late TextEditingController writeController = TextEditingController(
    text: widget.post?.writer ?? '',
  );
  late TextEditingController titleController = TextEditingController(
    text: widget.post?.title ?? '',
  );
  late TextEditingController contentController = TextEditingController(
    text: widget.post?.content ?? '',
  );

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    writeController.dispose();
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final writeState = ref.watch(writeViewModelProvider(widget.post));
    final vm = ref.read(writeViewModelProvider(widget.post).notifier);

    if (writeState.isWriting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () async {
                final result = formKey.currentState?.validate() ?? false;
                if (result) {
                  final insertResult = await vm.insert(
                    writer: writeController.text,
                    title: titleController.text,
                    content: contentController.text,
                  );
                  if (result) {
                    Navigator.pop(context);
                  }
                }
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: const Text(
                  '완료',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              TextFormField(
                controller: writeController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(hintText: '작성자'),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return '작성자를 입력해 주세요';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: titleController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(hintText: '제목'),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return '제목을 입력해 주세요';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 200,
                child: TextFormField(
                  controller: contentController,
                  maxLength: null,
                  // textInputAction: TextInputAction.newline,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(hintText: '내용'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return '내용을 입력해 주세요';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    final XFile? xFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    print(xFile);
                    if (xFile != null) {
                      vm.uploadImage(xFile);
                    }
                  },
                  child: writeState.imageUrl == null
                      ? Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey,
                          child: const Icon(Icons.image),
                        )
                      : SizedBox(
                          height: 100,
                          child: Image.network(
                            writeState.imageUrl!,
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
