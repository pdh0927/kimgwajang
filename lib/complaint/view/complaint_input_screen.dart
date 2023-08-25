import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kimgwajang/common/function/show_custon_dialog.dart';
import 'package:kimgwajang/complaint/provider/complaints_list_provider.dart';
import 'package:kimgwajang/inference/models/category_inference_request.dart';
import 'package:kimgwajang/inference/models/category_inference_result.dart';
import 'package:kimgwajang/inference/service/categorize_inference_service.dart';


class ComplaintInputScreen extends ConsumerStatefulWidget {
  const ComplaintInputScreen({super.key});

  @override
  ConsumerState createState() => _ComplaintInputScreenState();
}

class _ComplaintInputScreenState extends ConsumerState<ComplaintInputScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  File? _selectedImageFile;

  void onImagePicked(File? file) {
    setState(() {
      _selectedImageFile = file;
    });

    if (file != null) {
      // 여기서 이미지 파일이 선택되었을 때 수행해야 할 추가적인 작업을 할 수 있습니다.
      print('선택한 이미지 경로: ${file.path}');
    } else {
      print('이미지가 삭제되었습니다.');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '민원 입력하기',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '카테고리 걱정없이 편하게 민원을 넣으세요 :)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: '제목',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: '내용',
                  border: OutlineInputBorder(),
                ),
                maxLines: 15,
              ),
              Align(
                  alignment: Alignment.center,
                  child: PickedImage(imageFile: _selectedImageFile)),
              Align(
                alignment: Alignment.centerRight,
                child: ImagePickerButton(onImagePicked: onImagePicked),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text != '' &&
                        contentController.text != '') {
                      // 팝업창 표시
                      showCustomDialog(
                        context: context,
                        title: "알림",
                        content: "민원이 등록되었습니다.",
                      );

                      var service = CategorizeInferenceService();
                      service
                          .inference(CategoryInferenceRequest(
                              title: "민원", content: contentController.text))
                          .then((response) {
                        CategoryInferenceResult result = response;
                        ref
                            .read(uncompletedComplaintstListProvider.notifier)
                            .addComplaint(ComplaintModel(
                              title: titleController.text,
                              content: contentController.text,
                              reply: '',
                              categoryType: result.getCategoryType(),
                              imagePath: _selectedImageFile == null
                                  ? ''
                                  : _selectedImageFile!.path,
                            ));
                        titleController.text = '';
                        contentController.text = '';
                        setState(() {
                          _selectedImageFile = null;
                        });
                      });
                    }
                  },
                  child: const Text(
                    "완료",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

class ImagePickerButton extends StatelessWidget {
  final Function(File?) onImagePicked;

  const ImagePickerButton({super.key, required this.onImagePicked});

  Future<void> _selectImageFromGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
    Navigator.pop(context);
  }

  Future<void> _getImageFromCamera(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              title: const Text('이미지 선택'),
              children: <Widget>[
                const Divider(thickness: 1, height: 0),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('이미지 삭제'),
                  onTap: () {
                    onImagePicked(null);
                    Navigator.pop(context);
                  },
                ),
                const Divider(thickness: 1, height: 0),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('갤러리에서 선택'),
                  onTap: () => _selectImageFromGallery(context),
                ),
                const Divider(thickness: 1, height: 0),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('카메라로 촬영'),
                  onTap: () => _getImageFromCamera(context),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add_a_photo_outlined));
  }
}

class PickedImage extends StatelessWidget {
  final File? imageFile;

  const PickedImage({super.key, this.imageFile});

  @override
  Widget build(BuildContext context) {
    if (imageFile != null) {
      return Container(
          height: 200,
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Image.file(
            imageFile!,
            fit: BoxFit.fill,
          ));
    }
    return const SizedBox.shrink();
  }
}
