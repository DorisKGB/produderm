import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:produderm/src/bloc_application/b_application.dart';
import 'package:produderm/src/utils/bloc_pattern/bloc_base.dart';

import '../../../../application/repository/r_user_local.dart';
import '../../../router/pages.dart';

class BAdmin implements BlocBase {
  BAdmin(this._bApplication, this._rUserLocal);
  final BApplication _bApplication;
  final RUserLocal _rUserLocal;

  void closeSesion() {
    _rUserLocal.removeToken();
    navigator.go(Pages.signIn.getPath());
  }

  @override
  void dispose() {}

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
