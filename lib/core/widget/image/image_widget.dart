import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import '../../utils/theme/color_app.dart';
import '../../utils/theme/images.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key,
      required this.urlImage,
      this.height,
      this.width,
      this.errorWiget,
      this.scaleX = false,
      this.fit = BoxFit.cover});
  final String urlImage;
  final double? height;
  final double? width;
  final bool scaleX;
  final Widget? errorWiget;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    if (urlImage.trim() == "") {
      return _emptyImage();
    } else if (urlImage.contains("assets/")) {
      return _assestImage();
    } else {
      return _networkImage();
    }
  }

  Widget _networkImage() {
    return SizedBox(
        height: height,
        width: width,
        child: Transform.scale(
            scaleX: scaleX ? -1 : 1,
            child: CachedNetworkImage(
                imageUrl: urlImage,
                cacheKey: urlImage + DateTime.now().day.toString(),
                filterQuality: FilterQuality.high,
                imageBuilder: _imageBuilder,
                placeholder: _loadingImage,
                errorWidget: _errorImage)));
  }

  Widget _imageBuilder(BuildContext ctx, ImageProvider<Object> imageProvider) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
          // colorFilter: const ColorFilter.mode(
          //     mainOneColor, BlendMode.colorBurn)
        ),
      ),
    );
  }

  Widget _loadingImage(BuildContext ctx, String path) {
    return Center(
      child: Lottie.asset(TypeImage.LOADING_IMAGE),
    );
  }

  Widget _errorImage(BuildContext ctx, String path, dynamic error) {
    return errorWiget ??
        Center(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Image.asset(
              TypeImage.LOGO_WHITE,
              color: AppColors.mainOneColor,
            ),
          ),
        );
  }

  Widget _emptyImage() {
    return SizedBox(
      height: height,
      width: width,
      child: errorWiget ??
          Center(
            child: Image.asset(TypeImage.LOGO_COLORS,
                color: AppColors.mainOneColor),
          ),
    );
  }

  Widget _assestImage() {
    return SizedBox(
      height: height,
      width: width,
      child: Transform.scale(
        scaleX: scaleX ? -1 : 1,
        child: urlImage.contains(".svg")
            ? SvgPicture.asset(urlImage, fit: fit, height: height, width: width)
            : Image.asset(urlImage, fit: fit, height: height, width: width),
      ),
    );
  }
}
