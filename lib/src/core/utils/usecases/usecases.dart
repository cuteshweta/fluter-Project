import 'package:dartz/dartz.dart';

import '../../network/Failure.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class UseCaseNoParams<T> {
  Future<Either<Failure, T>> call();
}