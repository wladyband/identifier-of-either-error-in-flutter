import 'package:either/either.dart' as either;

void main(List<String> arguments) {
  final result = signIn('teste', '123456');

  if (result is SignInFailure) {
    late final String message;
    switch (result) {
      case SignInFailure.notFound:
        message = 'user not found';
        break;
      case SignInFailure.unauthorized:
        message = 'invalid password';
        break;
      case SignInFailure.unknow:
        message = 'internal erro';
        break;
    }
    print(message);
  } else {
    print("success ${result}");
  }
}

dynamic signIn(String username, String password) {
  if (username != 'teste') {
    return SignInFailure.notFound;
  }
  if (password != '123456') {
    return SignInFailure.unauthorized;
  }
  return 'userId';
}

enum SignInFailure { notFound, unauthorized, unknow }
