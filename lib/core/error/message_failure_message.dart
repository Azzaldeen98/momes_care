import '../utils/function/choose_name_langauge.dart';

import '../constants/failure.dart';
import 'faiture.dart';


String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return  SERVER_FAILURE_MESSAGE_AR;


    case EmptyCacheFailure:
      return EMPTY_CACHE_FAILURE_MESSAGE_AR;

    case OfflineFailure:
      return OFFLINE_FAILURE_MESSAGE_AR;

    case InvalidEmailOrPasswordFailure:
      return INVALID_EMAIL_OR_PASSWORD_AR;

    case OTPNotValiedFailure:
      return OTP_NOT_VALIED_AR;

    case OldPasswordFailure:
      return OLD_PASSWORD_AR;

    case CustomerExistisFailure:
      return CUSTOMER_EXISTIS_AR;

    case AccountNotActiveFailure:
      return ACCOUNT_NOT_ACTIVE_AR;

    case CustomerNotFoundFailure:
      return CUSTOMER_NOT_FOUND_AR;

    default:
      return UNEXPECTED_FAILURE_MESSAGE_AR;
  }
}
String mapFailureToMessage2(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return chooseLableLanguage(
          arabicLable: SERVER_FAILURE_MESSAGE_AR,
          englishLable: SERVER_FAILURE_MESSAGE_EN);

    case EmptyCacheFailure:
      return chooseLableLanguage(
          arabicLable: EMPTY_CACHE_FAILURE_MESSAGE_AR,
          englishLable: EMPTY_CACHE_FAILURE_MESSAGE_EN);

    case OfflineFailure:
      return chooseLableLanguage(
          arabicLable: OFFLINE_FAILURE_MESSAGE_AR,
          englishLable: OFFLINE_FAILURE_MESSAGE_EN);

    case InvalidEmailOrPasswordFailure:
      return chooseLableLanguage(
          arabicLable: INVALID_EMAIL_OR_PASSWORD_AR,
          englishLable: INVALID_EMAIL_OR_PASSWORD_EN);

    case OTPNotValiedFailure:
      return chooseLableLanguage(
          arabicLable: OTP_NOT_VALIED_AR, englishLable: OTP_NOT_VALIED_EN);

    case OldPasswordFailure:
      return chooseLableLanguage(
          arabicLable: OLD_PASSWORD_AR, englishLable: OLD_PASSWORD_EN);

    case CustomerExistisFailure:
      return chooseLableLanguage(
          arabicLable: CUSTOMER_EXISTIS_AR, englishLable: CUSTOMER_EXISTIS_EN);

    case AccountNotActiveFailure:
      return chooseLableLanguage(
          arabicLable: ACCOUNT_NOT_ACTIVE_AR,
          englishLable: ACCOUNT_NOT_ACTIVE_EN);

    case CustomerNotFoundFailure:
      return chooseLableLanguage(
          arabicLable: CUSTOMER_NOT_FOUND_AR,
          englishLable: CUSTOMER_NOT_FOUND_EN);

    default:
      return chooseLableLanguage(
          arabicLable: UNEXPECTED_FAILURE_MESSAGE_AR,
          englishLable: UNEXPECTED_FAILURE_MESSAGE_EN);
  }
}
