import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/data/entities/author.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/utils/theme/color_app.dart';
import 'package:moms_care/features/profile/persention/pages/author_profile_view.dart';
import '../image/image_widget.dart';

class CardAuthorWidget extends StatelessWidget {
  const CardAuthorWidget({super.key, this.onDelete,  this.author});
  final Author? author;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewAuthorProfile,
      child: Container(
        padding: const EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(2),
              height: 50,
              width: 50,
              decoration: BoxDecoration(

                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.grayThreeColor)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: ImageWidget(
                  urlImage:  (author!.image==null || author!.image!.isEmpty) ? AppImage.USER_GREEN :
                  author!.image!,// author!.image!=null ||author!.image!.isNotEmpty  ?author!.image! : AppImage.USER_GREEN,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(author!.name ?? "----",),
                const SizedBox(height: 0),
              ],
            )),
          ],
        ),
      ),
    );
  }


  void onViewAuthorProfile() {
    if(author!=null) {
        Get.to(AuthorProfileView(authorId:author!.id!,));
    }

  }
}
