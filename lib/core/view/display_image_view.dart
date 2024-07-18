import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';

import '../../../core/utils/theme/images.dart';


class DisplayImageView extends StatelessWidget {
  const DisplayImageView({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Image.asset(
          TypeImage.LOGO_WHITE,
          height: 40,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ImageWidget(
          urlImage: imageUrl,
          width: Get.width,
          fit: BoxFit.fitWidth,
          //  errorWiget: _errorImage(),
        ),
      ),
    );
  }

  Widget _errorImage() {
    return Center(
      child: Image.asset(
        TypeImage.PROFILE_IMAGE,
        fit: BoxFit.fill,
        width: Get.width,
        height: Get.width,
      ),
    );
  }
}
