<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->
# Bignumbers - Dart

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

<!-- ## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more. -->
