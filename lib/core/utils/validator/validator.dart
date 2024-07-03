extension ValidatorX on String {
  String? Function(String?)? validator() {
    return (value) {
      if (value != null && value.isNotEmpty) {
        return null;
      } else {
        return this;
      }
    };
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
        return this;
      }
    };
  }

  String? Function(String?)? validatorMobile() {
    return (value) {
      if (value != null && value.isNotEmpty && value.length == 9) {
        return null;
      } else {
        return "";
      }
    };
  }
}
