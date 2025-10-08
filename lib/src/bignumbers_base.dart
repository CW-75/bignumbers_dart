// Bignumber class for handling large numbers with precision
final class Bignumber<T> implements Comparable<Bignumber<T>> {
  BigInt _n = BigInt.zero;
  int _d = 0;
  bool _s = false;

  /// Validates if the string is a valid number format
  void _validNumString(String value) {
    RegExp regex = RegExp(r'^[+-]?(\d+(\.\d*)?|\.\d+)([eE][+-]?\d+)?$');
    if (!regex.hasMatch(value)) {
      throw ArgumentError('Invalid number string: $value');
    }
  }

  @override
  int compareTo(Bignumber<T> other) {
    return _n == other._n && _d == other._d
        ? 0
        : _n / BigInt.from(10).pow(_d) >
              other._n / BigInt.from(10).pow(other._d)
        ? 1
        : -1;
  }

  /// Trims trailing zeros from the decimal part of the number string
  String _trimRightZeros(String value) {
    value = value.replaceAll(RegExp(r'0+$'), '');
    if (value.endsWith('.')) {
      value = value.substring(0, value.length - 1);
    }
    return value;
  }

  // Checks if the value is a valid type for Bignumber
  bool _isValidvalue(T value) {
    if (value is String) {
      _validNumString(value);
    }
    return value is String ||
        value is int ||
        value is double ||
        value is Bignumber<T>;
  }

  /// Extracts the number of decimal places from the string representation
  /// only when is constructed from a string or double
  void _getDecimalsOnString(String value) {
    if (value.contains('.')) {
      var decimals = value.split('.').last;
      _d += decimals.length;
    }
  }

  String _searchNegativeExponential(String value) {
    if (value.contains('e-')) {
      var parts = value.split('e-');
      _d += int.parse(parts[1]);
      return parts[0];
    }
    return value;
  }

  /// Extracts the value from the provided type and sets the internal state
  void _getValue(T value) {
    if (value is String) {
      var newStr = _searchNegativeExponential(value);
      _getDecimalsOnString(newStr);
      _n = BigInt.parse(newStr.split('.').join());
    } else if (value is int || value is double) {
      var stringValue = value.toString();
      stringValue = _searchNegativeExponential(stringValue);
      _getDecimalsOnString(stringValue);
      _n = BigInt.parse(stringValue.split('.').join());
    }
  }

  String _setFinalValue(String value, int decimal) {
    var partInt = value.substring(0, value.length - decimal);
    var partDec = value.substring(value.length - decimal);
    return _trimRightZeros(
      '${partInt.isEmpty ? '0' : partInt}.${partDec.padLeft(decimal, '0')}',
    );
  }

  operator +(T other) {
    Bignumber otherNum = other is Bignumber ? other : Bignumber(other);
    var vala = _n;
    var valb = otherNum._n;
    int newDecimal;
    if (_d > otherNum._d) {
      valb *= BigInt.from(10).pow(_d - otherNum._d);
      newDecimal = _d;
    } else {
      vala *= BigInt.from(10).pow(otherNum._d - _d);
      newDecimal = otherNum._d;
    }
    var result = (vala + valb).toString();
    result = _setFinalValue(result, newDecimal);
    return Bignumber(result);
  }

  operator -(T other) {
    Bignumber otherNum = other is Bignumber ? other : Bignumber(other);
    var vala = _n;
    var valb = otherNum._n;
    String result;
    int newDecimal;
    if (_d > otherNum._d) {
      valb *= BigInt.from(10).pow(_d - otherNum._d);
      result = (vala - valb).toString();
      newDecimal = _d;
    } else {
      vala *= BigInt.from(10).pow(otherNum._d - _d);
      result = (vala - valb).toString();
      newDecimal = otherNum._d;
    }
    result = _setFinalValue(result, newDecimal);
    return Bignumber(result);
  }

  operator *(T other) {
    Bignumber otherNum = other is Bignumber ? other : Bignumber(other);
    var vala = _n;
    var multiplier = otherNum._n;
    var result = (vala * multiplier).toString();
    var newDecimal = _d + otherNum._d;
    result = _setFinalValue(result, newDecimal);
    return Bignumber(result);
  }

  operator /(T other) {
    Bignumber otherNum = other is Bignumber ? other : Bignumber(other);
    var vala = _n;
    var divisor = otherNum._n;
    if (divisor == BigInt.zero) {
      throw ArgumentError('Division by zero is not allowed');
    }
    if (vala == BigInt.zero) {
      return Bignumber(0);
    }
    var result = (vala / divisor).toString();
    var newDecLength = result.contains('.') ? result.split('.').last.length : 0;
    int newDecimal = _d > otherNum._d ? _d - otherNum._d : otherNum._d - _d;
    newDecimal += newDecLength;
    result = result.replaceAll('.', '');
    result = _setFinalValue(result, newDecimal);
    return Bignumber(result);
  }

  Bignumber pow(int exponent) {
    var result = _n.pow(exponent);
    var newDecimal = _d * exponent;
    var resultStr = _setFinalValue(result.toString(), newDecimal);
    return Bignumber(resultStr);
  }

  @override
  bool operator ==(Object other) {
    var otherValue = other is Bignumber ? other : Bignumber(other);
    return _n == otherValue._n && _d == otherValue._d && _s == otherValue._s;
  }

  Bignumber(T value, [int? decimal]) {
    if (!_isValidvalue(value)) {
      throw ArgumentError('Invalid type for Bignumber: ${value.runtimeType}');
    }
    _d = decimal ?? 0;
    _getValue(value);
  }

  @override
  String toString() {
    _s = _n.isNegative;
    var str = _n.toString().padRight(_d, '0');
    var integerPart = str.substring(0, str.length - _d);
    integerPart = integerPart.isEmpty ? '0' : integerPart;
    var decimalPart = _n.abs() % BigInt.from(10).pow(_d);
    return decimalPart == BigInt.zero
        ? integerPart.toString()
        : '${_s ? '-' : ''}${_trimRightZeros('${integerPart.toString()}.${decimalPart.toString().padLeft(_d, '0')}')}';
  }

  @override
  int get hashCode {
    return _n.hashCode ^ _d.hashCode ^ _s.hashCode;
  }
}
