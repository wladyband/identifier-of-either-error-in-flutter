void main(List<String> arguments) {
  final result = signIn('teste', '123456');
  final resultMessage = result.when(
    (failure) {
      final message = {
        SignInFailure.notFound: 'Not found',
        SignInFailure.unauthorized: 'Invalid password',
        SignInFailure.unknow: 'Internal erro',
      }[failure];
      return message;
    },
    (sessionId) => 'Success',
  );
  print(resultMessage);
}

Either<SignInFailure, String> signIn(String username, String password) {
  if (username != 'teste') {
    return Either.left(SignInFailure.notFound);
  }
  if (password != '123456') {
    return Either.left(SignInFailure.unauthorized);
  }
  return Either.right('sessionId');
}

enum SignInFailure { notFound, unauthorized, unknow }

class Either<Left, Right> {
  final Left? _left;
  final Right? _right;
  final bool isLeft;

  Either._(this._left, this._right, this.isLeft);

  factory Either.left(Left failure) {
    return Either._(failure, null, true);
  }
  factory Either.right(Right value) {
    return Either._(null, value, false);
  }
  T when<T>(
    T Function(Left) left,
    T Function(Right) right,
  ) {
    if (isLeft) {
      return left(_left!);
    } else {
      return right(_right!);
    }
  }
}
