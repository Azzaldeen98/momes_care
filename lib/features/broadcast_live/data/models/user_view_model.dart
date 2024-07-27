


import 'package:moms_care/core/constants/enam/broadcast_live_status.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/user_view.dart';


class UserViewModel extends UserView {


  UserViewModel({
    super.id,
    super.email,
    super.displayName,
    super.role,
    super.urlImage,
  });

  // دالة تحويل البيانات من JSON إلى كائن UserView
  factory UserViewModel.fromJson(Map<String, dynamic> json) {
    return UserViewModel(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      role: json['role'],
      urlImage: json['urlImage'],
    );
  }

  // دالة تحويل كائن UserView إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'role': role,
      'urlImage': urlImage,
    };
  }

  // دالة تحويل كائن Entity إلى كائن UserView
  factory UserViewModel.fromEntity(UserView entity) {
    return UserViewModel(
      id: entity.id,
      email: entity.email,
      displayName: entity.displayName,
      role: entity.role,
      urlImage: entity.urlImage,
    );
  }

  // دالة تحويل كائن UserView إلى كائن Entity
  UserView toEntity() {
    return UserView(
      id: id,
      email: email,
      displayName: displayName,
      role: role,
      urlImage: urlImage,
    );
  }


}



