import 'package:either/either.dart' as either;

void main(List<String> arguments) {
  final list = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int sum = 0;
  for (int i = 0; i < list.length; i++) {
    final value = list[i];
    sum = sum + value;
  }
  print(sum);
}
