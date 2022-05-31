class ValidatorUtils {
  static bool isValidName(String? name) {
    if (name != null && name.length > 3) {
      return true;
    }
    return false;
  }

  static bool isNotEmpty(String? name) {
    if (name != null && name.isNotEmpty) {
      return true;
    }
    return false;
  }

  static bool isValidPhone(String number) {
    return RegExp(r'^[0-9-+\(\)\ ]*$').hasMatch(number);
  }

  static bool isValidPassword(String? name) {
    if (name != null && name.length > 5) {
      return true;
    }
    return false;
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool isValidNumber(String num) {
    int? number = int.tryParse(num);
    return number == null;
  }

  static bool isValidDecimal(String num) {
    double? number = double.tryParse(num);
    return number == null;
  }
}
