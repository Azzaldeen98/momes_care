import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:moms_care/core/utils/validator/validator.dart';
import '../../utils/theme/color_app.dart';
import '../../utils/theme/images.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatefulWidget {

  const ImageWidget(
      {super.key,
        required this.urlImage,
        this.height,
        this.radius,
        this.width,
        this.errorWiget,
        this.scaleX = false,
        this.fit = BoxFit.cover});
  final String urlImage;
  final double? height;
  final double? width;
  final double? radius;
  final bool scaleX;
  final Widget? errorWiget;
  final BoxFit fit;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();



}
class _ImageWidgetState extends State<ImageWidget> {


   @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    if (widget.urlImage==null || widget.urlImage!.trim() == "") {
      return _emptyImage();
    } else if(widget.urlImage!.validatorImagePath()==null) {
        if (widget.urlImage!.contains("assets/")) {
          return _assestImage();
        } else if (widget.urlImage!.contains("http://") || widget.urlImage!.contains("https://")){
          return _networkImage();
        }else{
          return _fileImage(context);
        }
    }else{
      return _emptyImage();//(context,"",null);
    }
  }

  Widget _networkImage() {
    return SizedBox(
        height: widget.height,
        width: widget.width,
        child: Transform.scale(
            scaleX: widget.scaleX! ? -1 : 1,
            child: CachedNetworkImage(
                imageUrl: widget.urlImage!,
                cacheKey: widget.urlImage! + DateTime.now().day.toString(),
                filterQuality: FilterQuality.high,
                imageBuilder: _imageBuilder,
                placeholder: _loadingImage,
               )));
  }

  Widget _imageBuilder(BuildContext ctx, ImageProvider<Object> imageProvider) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius ?? 0),
        image: DecorationImage(
          image: imageProvider,
          fit: widget.fit,
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

  Widget _fileImage(BuildContext ctx) {
    var file= File(widget.urlImage!);
    return (file==null || file.path!.trim()=="")? _emptyImage()
        : Center(
          child: Image.file(
           file!,
            width: widget.width,
            height: widget.height,
            fit: BoxFit.cover,
        ),
    );
  }

  // Widget _errorImage(BuildContext ctx, String? path, dynamic? error) {
  //   return errorWiget ??
  //       Center(
  //         child: Padding(
  //           padding: const EdgeInsets.all(18),
  //           child: Image.asset(
  //             TypeImage.LOGO_WHITE,
  //             color: AppColors.mainOneColor,
  //           ),
  //         ),
  //       );
  // }
  //
  Widget _emptyImage() {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child:  widget.errorWiget ??
          Center(
            child: Image.asset(TypeImage.LOGO_COLORS,
                color: AppColors.mainOneColor),
          ),
    );
  }
  //
  Widget _assestImage() {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Transform.scale(
        scaleX: widget.scaleX! ? -1 : 1,
        child: widget!.urlImage!.contains(".svg")
            ? SvgPicture.asset(widget.urlImage!, fit: widget.fit!, height: widget.height, width: widget.width)
            : Image.asset(widget.urlImage!, fit: widget.fit, height: widget.height, width: widget.width),
      ),
    );
  }
}
