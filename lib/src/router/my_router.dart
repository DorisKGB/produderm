import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:produderm/application/repository/r_client.dart';
import 'package:produderm/src/pages/cliente/create/bloc/p_create_cliente.dart';
import 'package:produderm/src/pages/main/bloc/p_main.dart';

import '../bloc_application/b_application.dart';
import '../pages/login/bloc/p_login.dart';
import '../utils/bloc_pattern/bloc_provider.dart';
import '../utils/service_locator.dart';
import 'pages.dart';

class MyRouter {
  final ServiceLocator locator = ServiceLocator();
  late final router = GoRouter(
    initialLocation: Pages.signIn.getPath(),
    routes: [
      GoRoute(
          name: Pages.signIn.getKey(),
          path: Pages.signIn.getPath(),
          builder: (BuildContext context, GoRouterState state) => PLogin(
                bApplication: BlocProvider.of<BApplication>(context),
                rUser: locator.rUser,
                rUserLocal: locator.rUserLocal,
              )),
      GoRoute(
          name: Pages.main.getKey(),
          path: Pages.main.getPath(),
          builder: (BuildContext context, GoRouterState state) => PMain(
                bApplication: BlocProvider.of<BApplication>(context),
                rClient: locator.rClient,
                rProduct: locator.rProduct,
                rVisit: locator.rVisit,
                rUserLocal: locator.rUserLocal,
              )),
      GoRoute(
          name: Pages.createCliente.getKey(),
          path: Pages.createCliente.getPath(),
          builder: (BuildContext context, GoRouterState state) =>
              PCreateCliente(
                bApplication: BlocProvider.of<BApplication>(context),
                rClient: locator.rClient,
              )),
    ],
    //errorBuilder: (BuildContext context, GoRouterState state) => VError(error: state.error.toString()),
  );
}
