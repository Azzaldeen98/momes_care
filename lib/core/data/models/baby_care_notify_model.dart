import 'package:equatable/equatable.dart';

class BabyCareNotificationModel extends Equatable {
  final int babyId;
  final String babyName;
  final String message;

  const BabyCareNotificationModel({
    required this.babyId,
    required this.babyName,
    required this.message,
  });

  @override
  List<Object?> get props => [babyId, babyName, message];

  // Factory constructor to create an instance from JSON
  factory BabyCareNotificationModel.fromJson(Map<String, dynamic> json) {
    return BabyCareNotificationModel(
      babyId: json['babyId'],
      babyName: json['babyName'],
      message: json['message'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'babyId': babyId,
      'babyName': babyName,
      'message': message,
    };
  }
}
