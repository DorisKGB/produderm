import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc_application/b_application.dart';
import 'models/m_setting.dart';
import 'utils/bloc_pattern/bloc_provider.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BApplication bApplication;

  @override
  void initState() {
    // Busca el bloc BApplication
    bApplication = BlocProvider.of<BApplication>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MSetting>(
        initialData: bApplication.bSettings.setting,
        stream: bApplication.bSettings.outSetting, //salida tuberia
        builder: (BuildContext context, AsyncSnapshot<MSetting> snapshot) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('es', ''), // English, no country code
            ],
            onGenerateTitle: (BuildContext context) {
              bApplication.localization = AppLocalizations.of(context);
              return bApplication.translate.appTitle;
            },
            themeMode: snapshot.data?.themeMode,
            routerDelegate: bApplication.myRouter.router.routerDelegate,
            routeInformationParser:
                bApplication.myRouter.router.routeInformationParser,
          );
        });
  }
}
