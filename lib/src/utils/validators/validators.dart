import '../../../core/catalog/enum/c_errors.dart';
import 'validator_utils.dart';

class Validators {
  static CErrors? validateEmail(String? value) {
    if (!ValidatorUtils.isNotEmpty(value)) {
      return CErrors.requiredField;
    }

    if (!ValidatorUtils.isValidEmail(value!)) {
      return CErrors.invalidEmail;
    }

    return null;
  }

  /*static CErrors? validatePassword(String? value) {
    if (!ValidatorUtils.isNotEmpty(value)) {
      return CErrors.requiredField;
    }
    if (!ValidatorUtils.isValidPassword(value)) {
      return CErrors.invaliadPassword;
    }
    return null;
  }*/

  static CErrors? validateName(String? value) {
    if (!ValidatorUtils.isNotEmpty(value)) {
      return CErrors.requiredField;
    }

    if (!ValidatorUtils.isValidName(value)) {
      return CErrors.invalidName;
    }

    return null;
  }

  static CErrors? validateString(String? value) {
    if (!ValidatorUtils.isNotEmpty(value)) {
      return null;
    }

    if (!ValidatorUtils.isValidName(value)) {
      return CErrors.invalidName;
    }

    return null;
  }

  static CErrors? validateNumber(String? value) {
    if (!ValidatorUtils.isNotEmpty(value)) {
      return CErrors.requiredField;
    }
    if (ValidatorUtils.isValidNumber(value!)) {
      return CErrors.invalidNumber;
    }
    return null;
  }

  static CErrors? validateDecimal(String? value) {
    if (!ValidatorUtils.isNotEmpty(value)) {
      return null;
      //return CErrors.requiredField;
    }
    if (ValidatorUtils.isValidDecimal(value!)) {
      return CErrors.invalidNumber;
    }
    return null;
  }

  static CErrors? validateIdentification(String? value) {
    if (!ValidatorUtils.isNotEmpty(value)) {
      return CErrors.requiredField;
    }
    return null;
  }

  static CErrors? validateList(Iterable value) {
    if (value.isEmpty) {
      return CErrors.requiredField;
    }
    return null;
  }
}
