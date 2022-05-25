import 'package:flutter/material.dart';

import '../../../../application/repository/r_user.dart';
import '../../../../application/repository/r_user_local.dart';
import '../../../bloc_application/b_application.dart';
import '../../../utils/bloc_pattern/bloc_provider.dart';
import '../v_login.dart';
import 'b_login.dart';

class PLogin extends StatelessWidget {
  const PLogin(
      {Key? key,
      required this.bApplication,
      required this.rUser,
      required this.rUserLocal})
      : super(key: key);

  final BApplication bApplication;
  final RUser rUser;
  final RUserLocal rUserLocal;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BLogin>(
      // Crea o inyecta en el arbol al BLogin y este a su vez pueda acceder al proveedor padre BlocProvider
      blocBuilder: () =>
          BLogin(bApplication, rUser, rUserLocal), // El bloc a crear
      child: const VLogin(), // la vista a crear
    );
  }
}
