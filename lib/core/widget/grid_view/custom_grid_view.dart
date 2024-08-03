


import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/constants/enam/CareSchedulesItems.dart';
import 'package:moms_care/core/error/extination_valid.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';

class CustomGridViewInfo extends Equatable{

 const CustomGridViewInfo({
   required this.name,
   this.icon,
   this.imageUrl,
  });

  final String name;
  final Icon? icon;
  final String? imageUrl;

  @override
  List<Object?> get props => [name,icon,imageUrl];


}
class CustomGridViewWidget<T> extends StatelessWidget {
  final Function(int)? onSelectedItem;
  final Function(T)? onSelectedCustomItem;
  final Widget Function(T)? buildCustomItemWidget;
  final List<CustomGridViewInfo>? items;
  final Axis scrollDirection;
  final int crossAxisCount;
  final List<T>? customItems;
  final double childAspectRatio;
  final Color bgColor;
  final TextStyle textStyle;

  // final Widget? customItemWidget;
  const CustomGridViewWidget({super.key,
    this.onSelectedItem,
    this.onSelectedCustomItem,
    this.items,
    this.customItems,
    this.scrollDirection = Axis.horizontal,
    this.crossAxisCount = 1,
    this.childAspectRatio = 1.0,
    this.bgColor = Colors.white,
    this.buildCustomItemWidget,
    this.textStyle = const TextStyle(color: Colors.black),
  });


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: scrollDirection,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // عدد العناصر في المحور العمودي
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        childAspectRatio: childAspectRatio, // نسبة العرض إلى الارتفاع للعناصر
      ),
      padding: const EdgeInsets.all(10),
      itemCount: (customItems != null && customItems!.isNotEmpty) ? customItems
          ?.length : items?.length,
      // عدد العناصر في الشبكة
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (onSelectedItem != null) {
              onSelectedItem!(index);
            }
            if (onSelectedCustomItem != null && customItems != null) {
              onSelectedCustomItem!(customItems![index]);
            }
          },
          child: (customItems != null) ? buildCustomItemWidget!(
              customItems![index])
              : items == null ? _buildCustomGridItemWidget(
              const CustomGridViewInfo(name: " ", imageUrl: TypeImage.LOGO_COLORS),context)
              : _buildCustomGridItemWidget(items?[index],context),
        );
      },
    );
  }

  Widget _buildCustomGridItemWidget(CustomGridViewInfo? item,BuildContext context) {
    // ImageProvider img = item!.imageUrl!.isValidImageLocalURL ? AssetImage(
    //     item.imageUrl!) : NetworkImage(item.imageUrl!);
    return item == null ? const SizedBox() :
    Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // if(items[0]!.imgUrlBack!=null)
          image: (item.imageUrl == null) ? null : item!.imageUrl!
              .isValidImageLocalURL ? _builderDecorationImage(AssetImage(item.imageUrl!))
              : _builderDecorationImage(NetworkImage(item.imageUrl!)),
          color: bgColor,
          border: Border.all(color: AppColor.opacitybgCololr),
          borderRadius: BorderRadius.circular(16)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(item.icon != null)
              Icon(item.icon?.icon, color: item.icon?.color,
                size: item.icon?.size,),
            const SizedBox(height: 20,),
            Text(
              item.name,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }

  DecorationImage _builderDecorationImage(ImageProvider img) {
    return DecorationImage(
      image: img,
      fit: BoxFit.fill,);
  }
}