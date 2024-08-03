// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moms_care/core/local/locale_controller.dart';
import 'package:moms_care/core/utils/theme/color_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/utils/draw/triangle_clipper.dart';
import 'package:moms_care/core/utils/theme/theme_app.dart';
import 'package:moms_care/core/widget/button/change_language_button_widget.dart';
import 'package:moms_care/core/widget/text_field/text_field_shearsh_widget.dart';
import '../../bloc/moms_care/moms_care_bloc.dart';


class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key, required this.body});
  final Widget body;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final LocaleController localeController = Get.find();
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ClipPath(
              clipper: TriangleClipper(),
              child: Container(color: Colors.white)),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(children: [
                TextFieldSearchWidget(
                  lable: "ID".tr,
                  keyboardType: TextInputType.text,
                  searchController: searchController,
                  onChange: () {
                    if (searchController.text.trim().isNotEmpty) {
                      context
                          .read<MomsCareBloc>()
                          .add(GetMomsCareItemsEvent());
                    }
                    // else {
                    //   context.read<MomsCareBloc>().add(const GetSparePartEvent());
                    // }
                  },
                ),
                const SizedBox(height: 4),
                Container(
                    width: double.infinity,
                    height: 5,
                    decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(0, -1),
                          blurRadius: 1,
                          spreadRadius: 0.2,
                          blurStyle: BlurStyle.solid,
                          color: Colors.black),
                      BoxShadow(
                          offset: Offset(0, -4),
                          blurRadius: 1,
                          spreadRadius: 0.2,
                          blurStyle: BlurStyle.solid,
                          color: Colors.white)
                    ])),
                const SizedBox(height: 10),
                Expanded(child: widget.body)
              ]))
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(TypeImage.LOGO_COLORS, height: 36),
        leadingWidth: 65,
        actions: const [
          LanguageButtonWidget(),
          SizedBox(width: 35),
        ],
      ),
    );
  }
}
