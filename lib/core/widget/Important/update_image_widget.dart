import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../../utils/theme/color_app.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import '../../constants/api_servers.dart';

class UpdateImageWidget extends StatefulWidget {
  const UpdateImageWidget({Key? key, this.imageId, this.images})
      : super(key: key);
  final String? imageId;
  final List? images;
  @override
  UpdateImageWidgetState createState() => UpdateImageWidgetState();
}

class UpdateImageWidgetState extends State<UpdateImageWidget> {
  final List<String> uploadedImageUrls = [];
  final List<bool> _uploadingStates = [];
  List<String> get images => uploadedImageUrls;
  int lengthImages = 0;
  @override
  void initState() {
    uploadedImageUrls.addAll([...widget.images ?? []]);
    lengthImages = (widget.images ?? []).length;
    super.initState();
  }

  Future<void> _getImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    for (var pickedFile in pickedFiles) {
      //await UploadImageInFirebase.upload(File(pickedFile.path));
      await _uploadImage(File(pickedFile.path));
    }
  }

  Future<void> _uploadImage(File image) async {
    _uploadingStates.add(true);
    setState(() {});
    try {
      Reference ref;
      String dynamicImage = DateTime.now().toIso8601String();
      String email = Helper.auth?.userInfo?.email ?? "";
      var imagename = '$ID_IMAGE_PROFILE${email}_$dynamicImage';
      ref = FirebaseStorage.instance.ref("images").child(imagename);
      await ref.putFile(image);
      var imageurl = await ref.getDownloadURL();
      uploadedImageUrls.add(imageurl);
      setState(() {});
    } finally {
      _uploadingStates.removeLast();
      setState(() {});
    }
  }

  Future<void> _deleteImage(int index) async {
    if (index < lengthImages) {
      lengthImages -= 1;
    } else {
      FirebaseStorage.instance.refFromURL(uploadedImageUrls[index]).delete();
      //  ImageApi.deleteImage(url: uploadedImageUrls[index]);
    }
    uploadedImageUrls.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.mainOneColor, width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Row(
                children: List.generate(uploadedImageUrls.length, (index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ImageWidget(
                            urlImage: uploadedImageUrls[index],
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: InkWell(
                              onTap: () => _deleteImage(index),
                              child:
                                  Image.asset(AppImage.CLOSE_RED, width: 20))),
                    ],
                  );
                }),
              ),
            ),
          ),
          (_uploadingStates.isNotEmpty && _uploadingStates.last)
              ? const SizedBox(
                  width: 80,
                  child: Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: AppColors.secondaryOneColor,
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: _uploadingStates.isNotEmpty && _uploadingStates.last
                      ? null
                      : _getImages,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.all(10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryOneColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Text(
                        _uploadingStates.isNotEmpty && _uploadingStates.last
                            ? "جاري الرفع..."
                            : "Attaching images".tr,
                        style: AppTextStyles.getRegularStyle(
                          fontSize: 12,
                          color: Colors.white,
                        )),
                  ),
                ),
        ],
      ),
    );
  }
}
