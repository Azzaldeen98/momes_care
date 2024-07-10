import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/data/entities/author.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import '../../../config/theme/color_app.dart';
import '../../../config/theme/text_style.dart';
import '../label/text_newprice_widget.dart';
import '../label/text_widget.dart';
import '../image/image_widget.dart';

class CardAuthorWidget extends StatelessWidget {
  const CardAuthorWidget({super.key, this.onDelete,  this.author});
  final Author? author;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     border: Border.all(
      //         color: const Color.fromARGB(227, 225, 224, 224), width: 0.7),
      //     borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.grayThreeColor)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: ImageWiget(
                //(author.image==null || author.image!.isEmpty) ? AppImage.USER_GREEN :
                urlImage: author!.image ?? AppImage.USER_GREEN,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextWidget(author!.name ?? "----",),
              const SizedBox(height: 5),
              // TextWidget("author.id" ?? "----", fontSize: 14),
              // const SizedBox(height: 5),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Text(
              //         "sparePart.store?.name" ?? "---",
              //         style: AppTextStyles.getMediumStyle(
              //             fontSize: 14, color: AppColors.secondaryTwoColor),
              //       ),
              //     ),
              //     TextNewPriceWidget(
              //       newPrice: "${'sparePart.price' ?? "--"}",
              //       fontSize: 16,
              //     ),
              //     const SizedBox(width: 20),
              //   ],
              // ),

            ],
          )),
        ],
      ),
    );
  }

  // Widget _buildImage(BuildContext context,String urlToImage) {
  //   return CachedNetworkImage(
  //       imageUrl: urlToImage!,
  //       imageBuilder : (context, imageProvider) => Padding(
  //         padding: const EdgeInsetsDirectional.only(end: 14),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(20.0),
  //           child: Container(
  //             width: MediaQuery.of(context).size.width / 3,
  //             height: double.maxFinite,
  //             decoration: BoxDecoration(
  //                 color: Colors.black.withOpacity(0.08),
  //                 image: DecorationImage(
  //                     image: imageProvider,
  //                     fit: BoxFit.cover
  //                 )
  //             ),
  //           ),
  //         ),
  //       ),
  //       progressIndicatorBuilder : (context, url, downloadProgress) => Padding(
  //         padding: const EdgeInsetsDirectional.only(end: 14),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(20.0),
  //           child: Container(
  //             width: MediaQuery.of(context).size.width / 3,
  //             height: double.maxFinite,
  //             child: CupertinoActivityIndicator(),
  //             decoration: BoxDecoration(
  //               color: Colors.black.withOpacity(0.08),
  //             ),
  //           ),
  //         ),
  //       ),
  //       errorWidget : (context, url, error) =>
  //           Padding(
  //             padding: const EdgeInsetsDirectional.only(end: 14),
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(20.0),
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width / 3,
  //                 height: double.maxFinite,
  //                 child: Icon(Icons.error),
  //                 decoration: BoxDecoration(
  //                   color: Colors.black.withOpacity(0.08),
  //                 ),
  //               ),
  //             ),
  //           )
  //   );
  // }

}
