import 'package:flutter/material.dart';
import 'package:produderm/application/repository/r_client.dart';

import '../../../../bloc_application/b_application.dart';
import '../../../../utils/bloc_pattern/bloc_provider.dart';
import '../v_create_cliente.dart';
import 'b_create_cliente.dart';

class PCreateCliente extends StatelessWidget {
  const PCreateCliente(
      {Key? key, required this.bApplication, required this.rClient})
      : super(key: key);
  final BApplication bApplication;
  final RClient rClient;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BCreateCliente>(
      blocBuilder: () => BCreateCliente(bApplication, rClient),
      child: const VCreateClente(),
    );
  }
}
