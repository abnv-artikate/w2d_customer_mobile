import 'package:equatable/equatable.dart';
import 'package:w2d_customer_mobile/core/utils/constants.dart';

/// Parent class for all failures in Domain Layer\
/// Parent class for all failures in Domain Layer
abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = Constants.errorUnknown});

  @override
  List<Object> get props => [];
}

/// Remote failure in Domain Layer
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

/// Cache failure in Domain Layer
class CacheFailure extends Failure {
  // final String message;

  const CacheFailure({required super.message});
}
