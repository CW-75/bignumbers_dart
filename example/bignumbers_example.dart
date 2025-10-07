import 'package:bignumbers/bignumbers.dart';

void main() {
  Bignumber num1 = Bignumber('15.65021471751152025');
  Bignumber num2 = Bignumber('10.00000000000000075');
  var result = num1 + num2;
  print(result.toString()); // Should print '25.000000000000001'
  Bignumber num3 = Bignumber('1000');
  print(num1 * num3); // Should print '15000.0000000000000025'
  Bignumber num4 = Bignumber(2.00005);
  print(num1 / num4); // Should print '6.0000000000000001'}
}
