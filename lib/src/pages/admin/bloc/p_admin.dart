import 'package:flutter/material.dart';
import '../../../../application/repository/r_user_local.dart';
import '../../../bloc_application/b_application.dart';
import '../../../utils/bloc_pattern/bloc_provider.dart';
import '../v_admin.dart';
import 'b_admin.dart';

class PAdmin extends StatelessWidget {
  const PAdmin({Key? key, required this.bApplication, required this.rUserLocal})
      : super(key: key);
  final BApplication bApplication;
  final RUserLocal rUserLocal;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BAdmin>(
      blocBuilder: () => BAdmin(bApplication, rUserLocal),
      child: VAdmin(),
    );
  }
}
