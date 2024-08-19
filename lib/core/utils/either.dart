abstract class Either<L, R> {
  const Either();

  factory Either.left(L value) = Left<L, R>;
  factory Either.right(R value) = Right<L, R>;

  T when<T>({
    required T Function(L) left,
    required T Function(R) right,
  });
}

class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  T when<T>({
    required T Function(L) left,
    required T Function(R) right,
  }) {
    return left(value);
  }
}

class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  T when<T>({
    required T Function(L) left,
    required T Function(R) right,
  }) {
    return right(value);
  }
}
