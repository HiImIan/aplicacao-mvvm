abstract class Result<T> {
  const Result();

  factory Result.ok(T value) = Ok._;

  factory Result.error(Exception error) = Error._;
}

final class Ok<T> extends Result<T> {
  final T value;

  const Ok._(this.value);
}

final class Error<T> extends Result<T> {
  Exception error;

  Error._(this.error);
}

extension ResultExtension on Object {
  Result ok() {
    return Result.ok(this);
  }
}

extension ResultErrorExtension on Exception {
  Result error() {
    return Result.error(this);
  }
}

extension ResultCasting<T> on Result<T> {
  Ok<T> get asOk => this as Ok<T>;
}

extension ResultErrorCasting<T> on Result<T> {
  Error<T> get asError => this as Error<T>;
}
