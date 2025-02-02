import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

//الاخطاء المتوقعة
//خطاء لايوجد نت
class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

//خطاء بسيرفر
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}
// خطاء  اذن الوصول الى السرفر
class AuthenticationFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// firebase error
class FirebaseFailure extends Failure {
  @override
  List<Object?> get props => [];
}// firebase error
class DioFailure extends Failure {
  @override
  List<Object?> get props => [];
}
// Authorize error
class AuthorizeFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// Error Failure
class ErrorFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// sigOut error
class SigOutFailure extends Failure {
  @override
  List<Object?> get props => [];
}
//خطاء بحالة لا توجد  بيانات بالكاش
class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

//خطاء بادخال البيانات
class WrongDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class InvalidEmailOrPasswordFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class OTPNotValiedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class OldPasswordFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CustomerExistisFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AccountNotActiveFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CustomerNotFoundFailure extends Failure {
  @override
  List<Object?> get props => [];
}
