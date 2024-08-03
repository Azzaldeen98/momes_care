import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/helpers/helpers.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';

import '../../utils/style/border_text_filed.dart';
import '../text_field/text_field_widget.dart';


class TimePickerDemoWidget extends StatefulWidget {
  final TextEditingController timeController;
  final String? Function(String?)? validator;
  const TimePickerDemoWidget({super.key,
     this.validator,
    required this.timeController}) ;

  @override
  _TimePickerDemoWidgetState createState() => _TimePickerDemoWidgetState();
}

class _TimePickerDemoWidgetState extends State<TimePickerDemoWidget> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked=TimeOfDay.now();
  bool outline=true;
  double radius=12;

@override
  void initState() {
   if(widget.timeController!=null && widget.timeController.text.length>3){
     _time=Helpers.parseTimeOfDay(widget.timeController!.text);
   }
    super.initState();
  }
  Future<Null> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
    ))!;
    setState(() {
      _time = picked;
      widget.timeController.text=Helpers.timeOfDayToString(_time);//
      print(picked);
    });
  }

  @override
  Widget build(BuildContext context) {

    return  Center(

        // Center is a layout widget. It takes 
        // a single child and positions it 
        // in the middle of the parent. 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IconButton(
            //   iconSize: 80,
            //   icon: Icon(
            //     Icons.alarm,
            //     size: 80,
            //   ),
            //   onPressed: () {
            //     selectTime(context);
            //   },
            // ),
            const SizedBox(height: 20,),
            Text(Helpers.timeOfDayToString(_time), style: const TextStyle(fontSize: 40)),
            // const Divider(),
            TextFormField(
              controller: widget.timeController,
              validator: widget.validator,
              decoration: InputDecoration(
                labelText:  "Time".tr,
                hintText:  "Select time of day".tr,
                suffixIcon: const Icon(Icons.alarm),
                enabledBorder: BorderTextFiled.enabledBorder(outline, radius),
                focusedBorder: BorderTextFiled.focusedBorder(outline, radius),
                border: BorderTextFiled.border(outline, radius),
                errorBorder: BorderTextFiled.errorBorder(outline, radius),
              ),
              readOnly: true,
              onTap: () => selectTime(context),
            ),
          ],
        ), // Column 
      ); // Center
    // Scaffold
  }

  // TimeOfDay _durationToTimeOfDay(Duration duration) {
  //   int hours = duration.inHours;
  //   int minutes = duration.inMinutes.remainder(60);
  //   return TimeOfDay(hour: hours, minute: minutes);
  // }
  //

} 
