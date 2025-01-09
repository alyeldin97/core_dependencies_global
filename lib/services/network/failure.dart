import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class ServerFailure extends Failure {
  final int statusCode;

  ServerFailure(this.statusCode, {String? errorMessage})
      : super(_formatErrorMessage(statusCode, errorMessage: errorMessage));

  static String _formatErrorMessage(int statusCode, {String? errorMessage}) {
    switch (statusCode) {
      case 401:
        return "Un-Authorized access, Please login first then try again";
      case 404:
        return "This page was temporary removed, Please check it later";
      case 406:
        return errorCodes[errorMessage] ?? ApiErrorMessages.defaultError;
      case 500:
        return "Network Error, Please try again later";
      default:
        return errorMessage ?? ApiErrorMessages.defaultError;
    }
  }

  static const Map<String, String> errorCodes = {
    "Authentication.Email-Already-Exists": "Email already exists, please login",
    "POST-MEDIA-LIMIT-ERROR": "Media limit reached",
    "REFERRAL-TERMS-CONSENT-MISSING":
    "Please accept terms and conditions first",
    "REFERRAL-REWARD-ALREADY-CLAIMED": "This referral reward already claimed",
    "INVALID-REFERRAL-CODE": "Invalid referral code",
    "INVALID-VERIFICATION-CODE": "Invalid verification code",
    "WITHDRAWAL-AMOUNT-INVALID":
    "Withdrawal amount is invalid, please enter multiples of 1000",
    "INSUFFICIENT-BALANCE": "Insufficient balance",
    "UNVERIFIED": "Unverified, please verify your account first",
  };
}

class CacheFailure extends Failure {
  const CacheFailure(String errorMessage) : super(errorMessage);
}

class UnknownFailure extends Failure {
  const UnknownFailure({String errorMessage = ApiErrorMessages.defaultError})
      : super(errorMessage);
}
class ApiErrorMessages {
  static const String defaultError = 'Something went wrong';
  static const refreshed = 'Refreshed successfully';
}