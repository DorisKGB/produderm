import 'package:flutter/material.dart';

import '../../../../../application/repository/r_visit.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../utils/bloc_pattern/bloc_provider.dart';
import '../v_create_visit.dart';
import 'b_create_visit.dart';

class PCreateVisit extends StatelessWidget {
  const PCreateVisit({
    Key? key,
    required this.bApplication,
    required this.rVisit,
    required this.parametros,
  }) : super(key: key);
  final BApplication bApplication;
  final RVisit rVisit;
  final Map<String, dynamic> parametros;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BCreateVisit>(
      blocBuilder: () => BCreateVisit(bApplication, rVisit, parametros),
      child: const VCreateVisit(),
    );
  }
}
