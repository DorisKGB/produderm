import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum CErrors {
  requiredField,
  invalidEmail,
  invaliadPassword,
  diferentPassword,
  invalidName,
  invalidNumber,
  invalidDescription,
}

extension CErrorsDetail on CErrors {
  String getDescription(AppLocalizations translate) {
    switch (this) {
      case CErrors.requiredField:
        //return translate.requiredField;
        return 'vacio';
      case CErrors.invalidEmail:
        //return translate.requiredField;
        return 'vacio';
      case CErrors.invaliadPassword:
        //return translate.requiredField;
        return 'vacio';
      case CErrors.invalidName:
        //return translate.requiredField;
        return 'vacio';
      case CErrors.invalidNumber:
        //return translate.requiredField;
        return 'vacio';
      case CErrors.invalidDescription:
        //return translate.requiredField;
        return 'vacio';
      case CErrors.diferentPassword:
        //return translate.requiredField;
        return 'vacio';
    }
  }
}
