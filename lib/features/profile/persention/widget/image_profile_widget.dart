import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moms_care/core/view/display_image_view.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_state.dart';
import 'package:moms_care/features/profile/persention/widget/choose_type_image_button_widget.dart';
import '../../../../../core/utils/style/border_radius.dart';
import '../../../../../core/utils/theme/color_app.dart';
import '../../../../../core/utils/theme/images.dart';
import '../../../../../core/widget/button_sheet/line_button_sheet_widget.dart';
import '../../../../../core/widget/image/image_widget.dart';

// ignore: must_be_immutable
class ImageProfileWidget extends StatelessWidget {
  ImageProfileWidget({super.key, required this.urlImage});
  final String urlImage;
  final ImagePicker _picker = ImagePicker();
  File? imageProfile;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(61, 61, 61, 0.08),
                  blurRadius: 20,
                  offset: Offset(0, 1))
            ],
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(22),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is UploadImageSuccessfulState) {
                  return _imageWidget(state.urlImage);
                } else if (state is UpdateProfileSuccessfulState) {
                  return _imageWidget(state.profileInfo.image ?? "");
                } else {
                  return _imageWidget(urlImage);
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 135),
        Positioned(
          bottom: 0,
          child: InkWell(
            onTap: () => _showDialugeImagePaicker(context),
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Image.asset(AppImage.IMAGE_EDIT, height: 25),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _imageWidget(String urlImage) {
    return InkWell(
        onTap: () => _dispalyImage(urlImage),
        child: ImageWidget(
            urlImage: urlImage,
            width: 110,
            height: 110,
            errorWiget: _errorImage()));
  }

  Widget _errorImage() {
    return Center(
        child: Image.asset(TypeImage.PROFILE,
            fit: BoxFit.fill, width: 115, height: 115));
  }

  void _dispalyImage(String urlImage) {
    Get.to(() => DisplayImageView(imageUrl: urlImage));
  }

  void _showDialugeImagePaicker(BuildContext context) {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LineButtonSheetWidget(),
          ChooseTypeImageButtomWiget(
              name: "camera".tr,
              icon: IconlyBold.camera,
              onTap: () =>
                  _getLostData(context, imageSource: ImageSource.camera)),
          const SizedBox(height: 10),
          ChooseTypeImageButtomWiget(
              icon: IconlyBold.image,
              name: "gallery".tr,
              onTap: () =>
                  _getLostData(context, imageSource: ImageSource.gallery)),
          const SizedBox(height: 30),
        ],
      ),
      isScrollControlled: false,
      backgroundColor: const Color.fromRGBO(252, 252, 252, 1),
      shape: BorderRadiusAttributes.onlyTopRounded(30),
    );
  }

  // Capture a photo
  Future<void> _getLostData(BuildContext context,
      {required ImageSource imageSource}) async {
    try {
      final image = await _picker.pickImage(source: imageSource);
      if (image == null) {
        return;
      }
      File? img;
      Get.back();
      img = await cropImage(imageFile: File(image.path));
      if (img == null) {
        return;
      }
      imageProfile = img;
      // ignore: use_build_context_synchronously
      context.read<ProfileBloc>().uploadImage(img, urlImage);
    } on PlatformException catch (e) {
      Get.back();
      if (kDebugMode) {
        print(e.details);
      }
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      // aspectRatio: [CropAspectRatio()],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'SPS APP',
            toolbarColor: AppColors.mainOneColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(title: 'SPS APP'),
      ],
    );
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }
}
