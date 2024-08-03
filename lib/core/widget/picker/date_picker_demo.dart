import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/style/border_text_filed.dart';
import '../text_field/text_field_widget.dart';

class DatePickerDemoWidget extends StatefulWidget {

  const DatePickerDemoWidget({required this.dateControlle,
    this.hintText,this.name,this.initialDate});

  final TextEditingController dateControlle;
  final String? hintText;
  final String? name;
  final DateTime? initialDate;

  @override
  _DatePickerDemoWidgetState createState() => _DatePickerDemoWidgetState();
}

class _DatePickerDemoWidgetState extends State<DatePickerDemoWidget> {

  TextEditingController _dateController = TextEditingController();


  @override
  void initState() {

    _dateController=widget.dateControlle!;
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(), // التاريخ الافتراضي
      firstDate: DateTime(2020), // أول تاريخ يمكن اختياره
      lastDate: DateTime.now(), // آخر تاريخ يمكن اختياره
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var outline=true;
    double radius=12;
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: widget?.name ?? "",
              hintText: widget?.hintText ?? "",
              suffixIcon: Icon(Icons.calendar_today),
              enabledBorder: BorderTextFiled.enabledBorder(outline, radius),
              focusedBorder: BorderTextFiled.focusedBorder(outline, radius),
              border: BorderTextFiled.border(outline, radius),
              errorBorder: BorderTextFiled.errorBorder(outline, radius),
            ),
            readOnly: true,
            onTap: () => _selectDate(context),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

}


