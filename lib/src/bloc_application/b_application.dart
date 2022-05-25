import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../router/my_router.dart';
import '../router/pages.dart';
import '../utils/bloc_pattern/bloc_base.dart';
import 'blocs/b_settings.dart';

class BApplication implements BlocBase {
  BApplication() {
    bSettings = BSettings();
    myRouter = MyRouter();
    verifySession();
  }
  late MyRouter myRouter;
  late BSettings bSettings;
  AppLocalizations? localization;
  @override
  void dispose() {}

  void verifySession() async {
    if ((await myRouter.locator.rUserLocal.getToken()).token != null) {
      navigator.go(Pages.main.getPath());
    }
  }

  @override
  GoRouter get navigator => myRouter.router;

  @override
  AppLocalizations get translate => localization!;
}
