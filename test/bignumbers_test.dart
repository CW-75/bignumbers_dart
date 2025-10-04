import 'package:bignumbers/bignumbers.dart';
import 'package:test/test.dart';

void main() {
  group('Bignumber Instatiation Tests', () {
    test('Instantiate from string', () {
      var num1 = Bignumber('15.00000000000000025');
      expect(num1.toString(), '15.00000000000000025');
    });
    test('Instantiate from int', () {
      var num2 = Bignumber(1500000000000000);
      expect(num2.toString(), '1500000000000000');
    });

    test('Instantiate from double', () {
      var num3 = Bignumber(15.0000025);
      expect(num3.toString(), '15.0000025');
    });
  });

  group('Bignumber Arithmetic Tests', () {
    test('Addition of two Bignumbers', () {
      Bignumber num1 = Bignumber('15.00000000000000025');
      Bignumber num2 = Bignumber('10.00000000000000075');
      var result = num1 + num2;
      expect(result.toString(), '25.000000000000001');
    });

    test('Subtraction of two Bignumbers', () {
      Bignumber num1 = Bignumber('15.00000000000000025');
      Bignumber num2 = Bignumber('10.00000000000000075');
      var result = num1 - num2;
      expect(result.toString(), '4.9999999999999995');
    });

    test('Multiplication of two Bignumbers', () {
      Bignumber num1 = Bignumber('15.0000000000000000005');
      Bignumber num2 = Bignumber('2.0000000000000000001');
      var result = num1 * num2;
      print(result);
      expect(result, Bignumber('30.00000000000000000250000000000000000005'));
    });

    test('Division of two Bignumbers', () {
      Bignumber num1 = Bignumber('15.00000000000000025');
      Bignumber num2 = Bignumber('2.002');
      var result = num1 / num2;
      expect(result, Bignumber('7.492507492507492'));
    });
    group('commutativity', () {
      test('Addition is commutative', () {
        Bignumber num1 = Bignumber('15.00000000000000025');
        Bignumber num2 = Bignumber('10.00000000000000075');
        expect((num1 + num2), equals(num2 + num1));
      });

      test('Multiplication is commutative', () {
        Bignumber num1 = Bignumber('15.5');
        Bignumber num2 = Bignumber('2.0');
        expect(num1 * num2, equals(num2 * num1));
      });
    });
    group('Operations with another numerics types', () {
      test('Addition With int number', () {
        Bignumber num1 = Bignumber('15.00000000000000025');
        expect(num1 + 1, equals(Bignumber('16.00000000000000025')));
      });

      test('Multiplication is commutative', () {
        Bignumber num1 = Bignumber('15.5');
        expect(num1 - 0.5, equals(Bignumber('15')));
      });
    });
  });
}
