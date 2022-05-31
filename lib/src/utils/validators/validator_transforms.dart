import 'dart:async';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/catalog/enum/c_errors.dart';
import 'validators.dart';

mixin ValidatorTransForms {
  StreamTransformer<String, String> validateEmail(AppLocalizations translate) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String value, EventSink<String> skin) {
        final CErrors? error = Validators.validateEmail(value.trim());
        (error == null)
            ? skin.add(value.trim())
            : skin.addError(error.getDescription(translate));
      });

  /*StreamTransformer<String, String> validatePassword(
          AppLocalizations translate) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String value, EventSink<String> skin) {
        final CErrors? error = Validators.validatePassword(value);
        (error == null)
            ? skin.add(value)
            : skin.addError(error.getDescription(translate));
      });*/

  StreamTransformer<String, String> validateName(AppLocalizations translate) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String value, EventSink<String> skin) {
        final CErrors? error = Validators.validateName(value);
        (error == null)
            ? skin.add(value)
            : skin.addError(error.getDescription(translate));
      });
  StreamTransformer<String, String> validateString(
          AppLocalizations translate) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String value, EventSink<String> skin) {
        final CErrors? error = Validators.validateString(value);
        (error == null)
            ? skin.add(value)
            : skin.addError(error.getDescription(translate));
      });

  StreamTransformer<String, String> validateNumber(
          AppLocalizations translate) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String value, EventSink<String> skin) {
        final CErrors? error = Validators.validateNumber(value);
        (error == null)
            ? skin.add(value)
            : skin.addError(error.getDescription(translate));
      });

  StreamTransformer<String, String> validateDecimal(
          AppLocalizations translate) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String value, EventSink<String> skin) {
        final CErrors? error = Validators.validateDecimal(value);
        (error == null)
            ? skin.add(value)
            : skin.addError(error.getDescription(translate));
      });

  StreamTransformer<String, String> validateIdentification(
          AppLocalizations translate) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String value, EventSink<String> skin) {
        final CErrors? error = Validators.validateIdentification(value);
        (error == null)
            ? skin.add(value)
            : skin.addError(error.getDescription(translate));
      });
}
