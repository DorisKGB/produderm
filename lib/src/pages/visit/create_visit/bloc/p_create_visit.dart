import 'package:flutter/material.dart';
import '../../../../../application/repository/r_product.dart';
import '../../../../../application/repository/r_visit.dart';
import '../../../../../core/entities/cliente.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../utils/bloc_pattern/bloc_provider.dart';
import '../v_create_visit.dart';
import 'b_create_visit.dart';

class PCreateVisit extends StatelessWidget {
  const PCreateVisit({
    Key? key,
    required this.bApplication,
    required this.cliente,
    required this.rVisit,
  }) : super(key: key);
  final BApplication bApplication;
  final Cliente cliente;
  final RVisit rVisit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BCreateVisit>(
      blocBuilder: () => BCreateVisit(bApplication, cliente, rVisit),
      child: const VCreateVisit(),
    );
  }
}
