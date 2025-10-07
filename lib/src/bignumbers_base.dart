// Bignumber class for handling large numbers with precision
final class Bignumber<T> implements Comparable<Bignumber<T>> {
  BigInt _n = BigInt.zero;
  int _d = 0;
  bool _s = false;

  /// Validates if the string is a valid number format
  void _validNumString(String value) {
    RegExp regex = RegExp(r'^-?\d+(\.\d+)?$');
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

  void _getDecimalsOnString(String value) {
    if (value.contains('.')) {
      var decimals = value.split('.').last;
      _d = decimals.length;
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

  void _getValue(T value) {
    if (value is String) {
      _getDecimalsOnString(value);
      _n = BigInt.parse(value.split('.').join());
    } else if (value is int || value is double) {
      var stringValue = value.toString();
      stringValue = _searchNegativeExponential(stringValue);
      _getDecimalsOnString(stringValue);
      _n = BigInt.parse(stringValue.split('.').join());
    }
  }

  operator +(T other) {
    Bignumber otherNum = other is Bignumber ? other : Bignumber(other);
    var vala = _n;
    var valb = otherNum._n;
    if (_d > otherNum._d) {
      valb *= BigInt.from(10).pow(_d - otherNum._d);
      return Bignumber((vala + valb).toString(), _d);
    } else {
      vala *= BigInt.from(10).pow(otherNum._d - _d);
      return Bignumber((vala + valb).toString(), otherNum._d);
    }
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
    result = _trimRightZeros(
      '${result.substring(0, result.length - newDecimal)}.${result.substring(result.length - newDecimal)}',
    );
    return Bignumber(result);
  }

  operator *(T other) {
    Bignumber otherNum = other is Bignumber ? other : Bignumber(other);
    var vala = _n;
    var multiplier = otherNum._n;
    var result = (vala * multiplier).toString();
    var newDecimal = _d + otherNum._d;
    result = _trimRightZeros(
      '${result.substring(0, result.length - newDecimal)}.${result.substring(result.length - newDecimal)}',
    );
    return Bignumber(result);
  }

  operator /(T other) {
    Bignumber otherNum = other is Bignumber ? other : Bignumber(other);
    var vala = _n;
    var divisor = otherNum._n;
    if (otherNum._d > _d) {
      vala *= BigInt.from(10).pow(otherNum._d - _d);
    } else if (_d > otherNum._d) {
      divisor *= BigInt.from(10).pow(_d - otherNum._d);
    }
    print((vala / divisor).toString());
    // return Bignumber(BigInt.zero.toString(), 0);
    return Bignumber((vala / divisor).toString());
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
