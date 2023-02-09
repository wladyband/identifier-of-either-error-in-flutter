import 'package:either/either.dart' as either;

void main(List<String> arguments) {
  final result = signIn('teste', '123456');
  result.when(
    (failure) {
      final message = {
        SignInFailure.notFound: 'Not found',
        SignInFailure.unauthorized: 'Invalid password',
        SignInFailure.unknow: 'Internal erro',
      }[failure];
      print(message);
      return message;
    },
    (sessionId) {
      print('Success');
    },
  );
}

Either signIn(String username, String password) {
  if (username != 'teste') {
    return Either.left(SignInFailure.notFound);
  }
  if (password != '123456') {
    return Either.left(SignInFailure.unauthorized);
  }
  return Either.right('sessionId');
}

enum SignInFailure { notFound, unauthorized, unknow }

class Either<SignInFailure, String> {
  final SignInFailure? _left;
  final String? _right;
  final bool isLeft;

  Either._(this._left, this._right, this.isLeft);

  factory Either.left(SignInFailure failure) {
    return Either._(failure, null, true);
  }
  factory Either.right(String value) {
    return Either._(null, value, false);
  }
  when(
    Function(SignInFailure) left,
    Function(String) right,
  ) {
    if (isLeft) {
      left(_left!);
    } else {
      right(_right!);
    }
  }
}
