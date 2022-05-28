import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:produderm/core/entities/visit.dart';

import '../../core/entities/cliente.dart';
import '../bloc_application/b_application.dart';
import '../pages/cliente/create/bloc/p_create_cliente.dart';
import '../pages/login/bloc/p_login.dart';
import '../pages/main/bloc/p_main.dart';
import '../pages/producto/select_product/bloc/p_select_product.dart';
import '../pages/visit/create_visit/bloc/b_create_visit.dart';
import '../pages/visit/create_visit/bloc/p_create_visit.dart';
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
                rAdmin: locator.rAmin,
              )),
      GoRoute(
        name: Pages.createCliente.getKey(),
        path: Pages.createCliente.getPath(),
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> parametros = state.extra as Map<String, dynamic>;
          //final Cliente? cliente = state.extra as Cliente?;
          return PCreateCliente(
            bApplication: BlocProvider.of<BApplication>(context),
            rClient: locator.rClient,
            parametros: parametros,
          );
        },
      ),
      GoRoute(
        name: Pages.createVisit.getKey(),
        path: Pages.createVisit.getPath(),
        builder: (BuildContext context, GoRouterState state) {
          //final Visit visit = state.extra as Visit;
          Map<String, dynamic> parametros = state.extra as Map<String, dynamic>;
          return PCreateVisit(
            bApplication: BlocProvider.of<BApplication>(context),
            rVisit: locator.rVisit,
            parametros: parametros,
          );
        },
      ),
      GoRoute(
        name: Pages.selectProduct.getKey(),
        path: Pages.selectProduct.getPath(),
        builder: (BuildContext context, GoRouterState state) {
          final BCreateVisit bloc = state.extra as BCreateVisit;
          return PSelectProduct(
            bApplication: BlocProvider.of<BApplication>(context),
            bCreateVisit: bloc,
            rProduct: locator.rProduct,
            //rClient:  locator.rClient,
          );
        },
      ),
    ],
    //errorBuilder: (BuildContext context, GoRouterState state) => VError(error: state.error.toString()),
  );
}
