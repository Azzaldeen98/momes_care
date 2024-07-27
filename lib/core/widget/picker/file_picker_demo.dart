

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';

// class FilePickerDemo extends StatefulWidget {
//
//     final Function(String) onChoseFile;
//   const FilePickerDemo({required this.onChoseFile});
//
//   @override
//   _FilePickerDemoState createState() => _FilePickerDemoState();
// }
//
// class _FilePickerDemoState extends State<FilePickerDemo> {
//   File? _file;
//   void _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       setState(() {
//         _file = File(result.files.single.path!);
//       });
//           widget.onChoseFile(_file!.path);
//     } else {
//       // User canceled the picker
//     }
//   }
//   void _pickFile2() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       setState(() {
//         _file = File(result.files.single.path!);
//       });
//     } else {
//       // تم إلغاء اختيار الملف بواسطة المستخدم
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: _pickFile,
//               child: Text('Pick a file'),
//             ),
//             SizedBox(height: 20),
//             if (_file != null)
//               _file!.path.endsWith('.jpg') || _file!.path.endsWith('.png') || _file!.path.endsWith('.jpeg')
//                   ? Image.file(
//                 _file!,
//                 width: 200,
//                 height: 200,
//                 fit: BoxFit.cover,
//               )
//                   : Text('Selected file is not an image'),
//           ],
//         ),
//       );
//   }
// }


class FilePickerDemo extends StatefulWidget {

  final Function(String) onChoseFile;
  const FilePickerDemo({required this.onChoseFile});

  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  String? _filePath;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
        if(_filePath!=null) {
          widget.onChoseFile(File(_filePath!).path);
        }
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            CustomButton(
                widthPercent: 60,
                raduis: 10,
                labelText:'Pick a file'.tr,
                icon:const Icon(Icons.upload_file,color: AppColor.primaryIconColor,) ,
                bgColor: AppColor.PrimaryButtonLightColor,
                onPressed:_pickFile ),
            // ElevatedButton(
            //
            //   onPressed: _pickFile,
            //   child: Text('Pick a file'.tr,style: AppTextStyles.getBoldStyle(color: Colors.white),),
            // ),
            // SizedBox(height: 20),
            // if (_filePath != null)
            //   Text('Selected file: $_filePath'),
          ],
        ),
      );
  }
}