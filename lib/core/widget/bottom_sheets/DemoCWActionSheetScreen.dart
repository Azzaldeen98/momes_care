
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
// import 'package:nb_utils/nb_utils.dart';

import '../../utils/theme/app_color.dart';
import '../../../features/forum/presentation/wedgits/pages/add_update_post_widget.dart';
import '../../constants/enam/DemoCWActionSheetType.dart';  //https://pub.dev/packages/nb_utils




// class DemoCWActionBaseSheet extends StatefulWidget


Widget _buildDemoCWActionButton({String? name,required Callback onCallback,IconData? iconData}){
  return     CupertinoActionSheetAction(
    onPressed: () {
      Get.back();
      onCallback();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name!,
          style: AppTextStyles.getBasicStyle(color: AppColor.primaryTextColor,fontSize: 18),
        ),
        Icon(iconData, color:AppColor.primaryLightIconColor,)
      ],
    ),
  );
}



class DemoCWActionMoreOptionSheetScreen extends StatefulWidget {

  const DemoCWActionMoreOptionSheetScreen({required this.onLogOut});
  final Callback onLogOut;
  // ValueCallback sd;
  @override
  DemoCWActionMoreOptionSheetScreenState createState() => DemoCWActionMoreOptionSheetScreenState();
}

class DemoCWActionMoreOptionSheetScreenState extends State<DemoCWActionMoreOptionSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return    Theme(
      data:ThemeData.light(),
      child: CupertinoActionSheet(
        actions: [
          _buildDemoCWActionButton(name:'LogOut'.tr ,iconData: Icons.logout,onCallback: widget.onLogOut),
        ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              // finish(context);
              Get.back();
            },
            child: Text(
              'Cancel'.tr,
              style: AppTextStyles.getErrorStyle(fontSize: 18),
            )),
      ),
    );
  }



}

class DemoCWActionEditDeleteSheetScreen extends StatefulWidget {

  const DemoCWActionEditDeleteSheetScreen({
    required this.onEdited,required this.onDeleted});
  final Function(BuildContext context ) onDeleted;
  final Function(BuildContext context ) onEdited;
  // ValueCallback sd;
  @override
  DemoCWActionEditDeleteSheetScreenState createState() => DemoCWActionEditDeleteSheetScreenState();
}

class DemoCWActionEditDeleteSheetScreenState extends State<DemoCWActionEditDeleteSheetScreen> {
  @override
  Widget build(BuildContext context) {
   return    Theme(
     data:ThemeData.light(),
     child: CupertinoActionSheet(
       actions: [

         _buildActionButton(name:'Edit'.tr ,iconData: Icons.edit,onPressedButton: widget.onEdited),
         _buildActionButton(name:'Delete'.tr ,iconData:Icons.delete,onPressedButton: widget.onDeleted ),

       ],
       cancelButton: CupertinoActionSheetAction(
           onPressed: () {
             // finish(context);
             Get.back();
           },
           child: Text(
             'Cancel'.tr,
             style: AppTextStyles.getErrorStyle(fontSize: 18),
           )),
     ),
   );
  }

  Widget _buildActionButton({String? name,required Function(BuildContext context) onPressedButton,IconData? iconData}){
    return     CupertinoActionSheetAction(
      onPressed: () {
        Get.back();
        onPressedButton(context);
        // toasty(context, name);
        //
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name!,
            style: AppTextStyles.getBasicStyle(color: AppColor.primaryTextColor,fontSize: 18),
          ),
          Icon(iconData, color:AppColor.primaryLightIconColor,)
        ],
      ),
    );
  }

}



// class DemoCWActionSheetScreen extends StatefulWidget {
//
//   const DemoCWActionSheetScreen({required this.actionSheetType});
//   final DemoCWActionSheetType actionSheetType;
//
//
//   @override
//   DemoCWActionSheetScreenState createState() => DemoCWActionSheetScreenState();
// }
// class DemoCWActionSheetScreenState extends State<DemoCWActionSheetScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     if(widget.actionSheetType==DemoCWActionSheetType.ONE_ACTIONS)
//       return _buildAction1();
//     else if(widget.actionSheetType==DemoCWActionSheetType.TWO_ACTIONS)
//       return _buildAction2();
//     else if(widget.actionSheetType==DemoCWActionSheetType.EDIT_DELETE_SHEET)
//       return _buildAction3();
//     else
//       return SizedBox();
//   }
//
//
//
//   Theme _buildAction1(){
//     return Theme(
//       data:ThemeData.light(),
//       child: CupertinoActionSheet(
//         title: Text(
//           'Cupertino Action Sheet Example',
//           style: boldTextStyle(size: 18),
//         ),
//
//         // child: CupertinoActionSheet(
//         //   title:Expanded(
//         //     child: CreateUpdatePostWidget(onClickSaved:(t,c){
//         //
//         //     },onCreatedOrUpdatedIsSuccess: (){},baseContext: context,),
//         //   ),
//
//         message: Text('It\'s a demo for cupertino action sheet.'),
//         actions: [
//           CupertinoActionSheetAction(
//               onPressed: () {
//                 toasty(context, 'OK');
//                 finish(context);
//               },
//               child: Text('OK', style: primaryTextStyle(size: 18)))
//         ],
//         cancelButton: CupertinoActionSheetAction(
//             onPressed: () {
//               finish(context);
//             },
//             child: Text(
//               'Cancel',
//               style: primaryTextStyle(color: redColor, size: 18),
//             )),
//       ),
//     );
//   }
//   Theme _buildAction2(){
//     return Theme(
//       data:ThemeData.light(),
//       child: CupertinoActionSheet(
//         actions: [
//           CupertinoActionSheetAction(
//             onPressed: () {
//               finish(context);
//               toasty(context, 'Male Clicked');
//             },
//             child: Text(' 💁‍♂️ Male', style: primaryTextStyle(size: 18)),
//             isDefaultAction: true,
//           ),
//           CupertinoActionSheetAction(
//               onPressed: () {
//                 finish(context);
//                 toasty(context, 'Female Clicked');
//               },
//               child: Text(' 💁‍♀️ Female', style: primaryTextStyle(size: 18)))
//         ],
//         cancelButton: CupertinoActionSheetAction(
//             onPressed: () {
//               finish(context);
//             },
//             child: Text(
//               'Cancel',
//               style: primaryTextStyle(color: redColor, size: 18),
//             )),
//       ),
//     );
//   }
//   Theme _buildAction(){
//
//     return  Theme(
//       data:ThemeData.light(),
//       child: CupertinoActionSheet(
//         actions: [
//
//           _buildActionButton(name:'Edit'.tr ,iconData: Icons.edit ),
//           _buildActionButton(name:'Delete'.tr ,iconData:Icons.delete ),
//
//         ],
//         cancelButton: CupertinoActionSheetAction(
//             onPressed: () {
//               finish(context);
//             },
//             child: Text(
//               'Cancel',
//               style: primaryTextStyle(color: redColor, size: 18),
//             )),
//       ),
//     );
//   }
//
//   Widget _buildActionButton({String? name,Function()? onPressed,IconData? iconData}){
//     return     CupertinoActionSheetAction(
//       onPressed: () {
//         toasty(context, name);
//         onPressed!();
//         finish(context);
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             name!,
//             style: primaryTextStyle(size: 18),
//           ),
//           Icon(iconData, color:appStore.iconColor,)
//         ],
//       ),
//     );
//   }
// }
//
// class DemoCWActionSheetScreenState2 extends State<DemoCWActionSheetScreen> {
//   List<ListModel> example = [
//     ListModel(name: 'Cupertino action sheet 1'),
//     ListModel(name: 'Cupertino action sheet 2'),
//     ListModel(name: 'Cupertino action sheet 3'),
//   ];
//
//   @override
//   void initState() {
//
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //  if(widget.actionSheetType==DemoCWActionSheetType.EDIT_DELETE_SHEET)
//     //       showCupertinoModalPopup(context: context, builder: (BuildContext context) => _buildAction3());
//     // });
//     super.initState();
//     init();
//   }
//
//   init() async {}
//
//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     final action1 = Theme(
//       data:ThemeData.light(),
//       child: CupertinoActionSheet(
//         title: Text(
//                     'Cupertino Action Sheet Example',
//                     style: boldTextStyle(size: 18),
//                   ),
//
//       // child: CupertinoActionSheet(
//       //   title:Expanded(
//       //     child: CreateUpdatePostWidget(onClickSaved:(t,c){
//       //
//       //     },onCreatedOrUpdatedIsSuccess: (){},baseContext: context,),
//       //   ),
//
//         message: Text('It\'s a demo for cupertino action sheet.'),
//         actions: [
//           CupertinoActionSheetAction(
//               onPressed: () {
//                 toasty(context, 'OK');
//                 finish(context);
//               },
//               child: Text('OK', style: primaryTextStyle(size: 18)))
//         ],
//         cancelButton: CupertinoActionSheetAction(
//             onPressed: () {
//               finish(context);
//             },
//             child: Text(
//               'Cancel',
//               style: primaryTextStyle(color: redColor, size: 18),
//             )),
//       ),
//     );
//
//     final action2 = Theme(
//       data:ThemeData.light(),
//       child: CupertinoActionSheet(
//         actions: [
//           CupertinoActionSheetAction(
//             onPressed: () {
//               finish(context);
//               toasty(context, 'Male Clicked');
//             },
//             child: Text(' 💁‍♂️ Male', style: primaryTextStyle(size: 18)),
//             isDefaultAction: true,
//           ),
//           CupertinoActionSheetAction(
//               onPressed: () {
//                 finish(context);
//                 toasty(context, 'Female Clicked');
//               },
//               child: Text(' 💁‍♀️ Female', style: primaryTextStyle(size: 18)))
//         ],
//         cancelButton: CupertinoActionSheetAction(
//             onPressed: () {
//               finish(context);
//             },
//             child: Text(
//               'Cancel',
//               style: primaryTextStyle(color: redColor, size: 18),
//             )),
//       ),
//     );
//
//     final action3 = Theme(
//       data:ThemeData.light(),
//       child: CupertinoActionSheet(
//         actions: [
//           CupertinoActionSheetAction(
//               onPressed: () {
//                 toasty(context, 'Share App');
//                 finish(context);
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Share App',
//                     style: primaryTextStyle(size: 18),
//                   ),
//                   Icon(
//                     Icons.share,
//                     color: appStore.iconColor,
//                   )
//                 ],
//               )),
//           CupertinoActionSheetAction(
//             onPressed: () {
//               toasty(context, 'More by this Developer');
//               finish(context);
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'More by this Developer',
//                   style: primaryTextStyle(size: 18),
//                 ),
//                 Icon(
//                   Icons.supervised_user_circle,
//                   color: appStore.iconColor,
//                 )
//               ],
//             ),
//           ),
//         ],
//         cancelButton: CupertinoActionSheetAction(
//             onPressed: () {
//               finish(context);
//             },
//             child: Text(
//               'Cancel',
//               style: primaryTextStyle(color: redColor, size: 18),
//             )),
//       ),
//     );
//
//     return
//      Scaffold(
//        body: SafeArea(child:   ExampleItemWidget(example[2], onTap: () {
//          showCupertinoModalPopup(context: context, builder: (BuildContext context) => action3);
//           }
//         ),
//
//            ),
//      );
//   }
// }
//
// AppStore appStore = AppStore();
// class AppStore{
//
//   Color textPrimaryColor = Color(0xFF212121);
//   Color iconColorPrimaryDark = Color(0xFF212121);
//   Color scaffoldBackground = Color(0xFFEBF2F7);
//   Color backgroundColor = Colors.black;
//   Color backgroundSecondaryColor = Color(0xFF131d25);
//   Color appColorPrimaryLightColor = Color(0xFFF9FAFF);
//   Color textSecondaryColor = Color(0xFF5A5C5E);
//   Color appBarColor = Colors.white;
//   Color iconColor = Color(0xFF212121);
//   Color iconSecondaryColor = Color(0xFFA8ABAD);
//   Color cardColor = Colors.white;
//   Color appColorPrimary = Color(0xFF1157FA);
//   Color scaffoldBackgroundColor = Color(0xFFEFEFEF);
//
//   AppStore();
//
// }
// class ListModel {
//   String? name;
//   bool? isNew;
//   Widget? widget;
//
//   ListModel({this.name, this.widget,this.isNew});
// }
// class ExampleItemWidget extends StatelessWidget {
//   final ListModel tabBarType;
//   final Function onTap;
//   final bool showTrailing;
//
//   ExampleItemWidget(this.tabBarType, {required this.onTap, this.showTrailing = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: appStore.appBarColor,
//       margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
//       elevation: 2.0,
//       shadowColor: Colors.black,
//       child: ListTile(
//         onTap: () => onTap(),
//         title: Text(tabBarType.name!, style: boldTextStyle()),
//         trailing: showTrailing
//             ? Icon(Icons.arrow_forward_ios, size: 15, color: appStore.textPrimaryColor)
//             : tabBarType.isNew.validate()
//             ? Text('New', style: secondaryTextStyle(color: Colors.red))
//             : null,
//       ),
//     );
//   }
// }