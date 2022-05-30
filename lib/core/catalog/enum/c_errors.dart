import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum CErrors {
  requiredField,
  invalidEmail,
  invalidName,
  invalidNumber,
  //invalidDescription,
}

extension CErrorsDetail on CErrors {
  String getDescription(AppLocalizations translate) {
    switch (this) {
      case CErrors.requiredField:
        //return translate.requiredField;
        return 'El campo es requerido';
      case CErrors.invalidEmail:
        //return translate.requiredField;
        return 'El campo es de tipo email';
      case CErrors.invalidName:
        //return translate.requiredField;
        return 'Se requiere minimo 4 caracteres';
      case CErrors.invalidNumber:
        //return translate.requiredField;
        return 'El campo es numerico';
    }
  }
}
