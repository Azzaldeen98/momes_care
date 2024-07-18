import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/constants/enam/gender.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/features/profile/domain/entities/baby_entity.dart';

import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';
import 'package:moms_care/features/profile/persention/pages/baby/baby_details.dart';
import 'package:moms_care/features/profile/persention/widget/baby/baby_helper_methods.dart';
import '../baby/add_update_baby_page.dart';

class BabiesWidget extends StatelessWidget{

  BabiesWidget({ required this.babies});

  final List<Baby> babies;

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildBabiesBodyWidget(context),
              _buildFixedButtonAddBabyWidget(),
            ],
          ),
      ) ;
  }

  Widget _buildFixedButtonAddBabyWidget(){
    return  Positioned(
      top: 16.0, // المسافة من أسفل الشاشة
      left: 10.0, // المسافة من يمين الشاشة
      child: FloatingActionButton(
        onPressed:onClickAddBaby,
        child: Icon(Icons.add),
      ),
      // Container(
      //   decoration: BoxDecoration(
      //       color: AppColor.primaryColor,
      //       borderRadius: BorderRadius.circular(10)
      //   ),
      //   child: TextButton.icon(onPressed: ()=>onClickAddBaby(context),
      //       label:  Text("Baby".tr,style:AppTextStyles.getButtonTextStyle(),),
      //       icon: Icon(Icons.add,color: AppColor.whiteColor,)),
      // ) ,
    );
  }
  Widget _buildBabiesBodyWidget(BuildContext context){

    return (babies==null || babies!.isEmpty)
        ? EmptyWidget(explanatoryText: "EmptyBabies".tr)
        : SingleChildScrollView(
          child:ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context,index){
              final baby= babies![index];
              return  ListTile(
                // title: ,
                subtitle: Container(
                  child: Column(
                    children: [
                      _buildBabyItemWidget(baby),
                      Divider(),
                    ],
                  ),
                ) ,
                onTap: (){
                  Get.off(BabyDetailsPage(baby: baby));
                },
              );
            },
            itemCount: babies!.length,
          ),
        );
  }
  void onClickAddBaby(){
   Get.offAll(AddUpdateBabyPage());
  }
  Widget _buildBabyItemWidget(Baby baby){

    String imgUrl=(baby.image!.isNotEmpty)? baby.image!: getBabyIconByGender(baby.gender!);
    return    Container(
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              child:ImageWidget(urlImage:imgUrl),
            ),
            VerticalDivider(color: AppColor.primaryColor,),
            Column(
              children: [
                buildRowLabelWithValueWidget(label:"Name".tr,value:  baby.name!),
                buildRowLabelWithValueWidget(label:"Age".tr,value:baby.age!.toString()!),
              ],
            ),
          ],
        ));
  }




}


