# Bignumbers - Dart

[![Dart](https://github.com/CW-75/bignumbers_dart/actions/workflows/testing.yaml/badge.svg?branch=main)](https://github.com/CW-75/bignumbers_dart/actions/workflows/testing.yaml)

bignumbers is a high-performance library for arbitrary-precision arithmetic. Say goodbye to integer overflow and floating-point inaccuracy; calculate with numbers of any size with total precision.

bignumbers provides a robust implementation of arbitrary-precision integer and rational number arithmetic. Designed to overcome the limitations of native data types (like 64-bit integers and standard doubles), this library ensures mathematical exactness for computations involving extremely large numbers (beyond 2 
64
) or complex calculations where precision is paramount. It features optimized algorithms for addition, subtraction, multiplication, division, modulo operations, and power calculations.

## installation
```sh
dart pub add bignumbers
```


## Usage
```dart
Bignumber num1 = Bignumber(15);
Bignumber num2 = Bignumber('0.0000000000002');
num1 + num2 // 15.0000000000002
num1 - num2 // 14.9999999999998

```

Bignumbers was made it supporting generics models, so you can instatiate a bignumber using as parameter `int`, `double` or `string`, Also operations as sum are supported to work with 

```dart

```
