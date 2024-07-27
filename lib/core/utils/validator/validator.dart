import 'package:get/get.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/error/extination_valid.dart';

extension ValidatorX on String {
  String? Function(String?)? validator() {
    return (value) {
      if (value != null && value.isNotEmpty) {
        return null;
      } else {
        return INPUT_FIELD_NOT_BE_EMPTY;
      }
    };
  }
  String? Function(String?)? validatorURL() {
    return (value) {
      if (value != null && value.isNotEmpty ) {
        if(value.contains("https://")
            || value.contains("https://youtube/")
            ||  value.contains("https://youtu.be/"))
          return null;
      return INPUT_FIELD_NOT_CORRECT_URL;
      } else {
        return INPUT_FIELD_NOT_BE_EMPTY;
      }
    };
  }
  String?  validatorText() {

      if (this != null && this.isNotEmpty) {
        return null;
      } else {
        return INPUT_FIELD_NOT_BE_EMPTY;
      }
  }

  String? Function(dynamic)? validator2() {
    return (value) {
      if (value != null && value.toString().isNotEmpty) {
        return null;
      } else {
        return toString();
      }
    };
  }

  String? Function(dynamic)? validatorDropDown() {
    return (value) {
      if (value != null) {
        return null;
      } else {
        return INPUT_FIELD_NOT_BE_EMPTY;
      }
    };
  }


  // String? Function(String?)? validatorMobile() {
  String? validatorMobile() {
      if (this != null && this.isNotEmpty && this.length == 9) {
        return null;
      }else{
        return INPUT_FIELD_PHONE_NUMBER_NOT_CORRECT;
      }

  }

  String?  validatorImagePath() {
      if (this != null && this.isNotEmpty
          && (this.contains('.jpg') ||
              this.contains('.png') ||
              this.contains('.jpeg') ||
              this.contains('.bmp') ||
              this.contains('.gif'))) {
        return null;  // الملف هو صورة صالحة
      } else {
        return 'Please select a valid image file'.tr;  // رسالة خطأ في حال كان الملف غير صالح
      }

  }

}
