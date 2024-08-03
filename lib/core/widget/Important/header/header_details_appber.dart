
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/draw/triangle_clipper.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import '../../../utils/function/choose_name_langauge.dart';
import '../../../utils/theme/color_app.dart';
import '../../../utils/theme/images.dart';

class HeaderDetailsAppber extends StatelessWidget {
  const HeaderDetailsAppber(
      {super.key, required this.body, required this.title});
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Helper.buttonNavigation,
        body: Stack(
          children: [
            ClipPath(
                clipper: TriangleClipper(),
                child: Container(color: Colors.white)),
            Padding(padding: EdgeInsets.zero, child: body)
          ],
        ),
        appBar: _AppbarWidget(title));
  }
}

class _AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const _AppbarWidget(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainTwoColor,
      shape: ShapeBorder.lerp(
          const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(25.0))),
          null,
          0),
      elevation: 0,
      centerTitle: false,
      title: Text(
        title,
        style: AppTextStyles.getShamelBoldStyle(
            color: AppColors.secondaryOneColor, fontSize: 16),
      ),
      //Image.asset(TypeImage.LOGO_TEXT, height: 36),
      leadingWidth: 20,
      leading: const SizedBox(),
      actions: const [_CloseWidget(), SizedBox(width: 20)],
    );
  }

  @override
  Size get preferredSize => const Size(1, 75);
}

class _CloseWidget extends StatelessWidget {
  const _CloseWidget();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Get.back(),
        child: Container(
          height: 54,
          width: 54,
          padding: const EdgeInsets.all(12),
          decoration: AppBoxDecoration.greenBoxDecoration.copyWith(
            color: Colors.white.withOpacity(0.5),
          ),
          child: Transform.scale(
              scaleX: chooseLanguage(arabic: -1, english: 1),
              child: Image.asset(
                AppImage.ARROW_RIGHT_P,
                color: Colors.black,
                width: 20,
                height: 20,
              )),
        ));
  }
}
