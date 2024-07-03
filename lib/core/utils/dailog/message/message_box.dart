import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../theme/font_manager.dart';
import '../../theme/images.dart';
import '../../theme/text_style.dart';

class MessageBox {
  static void awesomeDialogWidget(BuildContext context) {
    var awesomeDialog =
        AwesomeDialog(context: context, title: "", body: const Text(""));
    awesomeDialog.show();
  }

  static void show(BuildContext context, String message) {
    MessageBox.showDialog(context,
        textBody: message, circularProgressIndicator: true, isDismi: false);
  }

  static void showWarning(BuildContext context, String message) {
    MessageBox.showDialog(context,
        textBody: message, dialogType: DialogType.warning);
  }

  static void showError(BuildContext context, String message) {
    MessageBox.showDialog(context,
        textBody: message, dialogType: DialogType.error);
  }

  static void showSuccess(BuildContext context, String message) {
    MessageBox.showDialog(context,
        textBody: message, dialogType: DialogType.success);
  }

  static void showProgress(BuildContext context, String message) {
    MessageBox.showDialog(context,
        textBody: message, circularProgressIndicator: true, isDismi: false);
  }

  static void showDialog(BuildContext context,
      {bool isDismi = true,
      DialogType dialogType = DialogType.noHeader,
      required String textBody,
      bool circularProgressIndicator = false}) {
    AwesomeDialog awesomeDialog = AwesomeDialog(
        context: context,
        dialogType: dialogType,
        dismissOnTouchOutside: isDismi,
        dismissOnBackKeyPress: isDismi,
        body: _MessageBoxWidget(
          textBody: textBody,
          circularProgressIndicator: circularProgressIndicator,
        ));
    awesomeDialog.show();
  }
}

class _MessageBoxWidget extends StatelessWidget {
  const _MessageBoxWidget({
    required this.textBody,
    this.circularProgressIndicator = false,
  });

  final String textBody;
  final bool circularProgressIndicator;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: circularProgressIndicator == false
          ? Text(textBody,
              textAlign: TextAlign.center,
              style: AppTextStyles.getMediumStyle(fontSize: 16))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                if (circularProgressIndicator)
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: Lottie.asset(TypeImage.LOADING_CIRCLE_IMAGE)),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    textBody,
                    //textAlign: TextAlign.right,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamilyNames.dINNextLTArabicRegular),
                  ),
                ),
              ],
            ),
    );
  }
}
