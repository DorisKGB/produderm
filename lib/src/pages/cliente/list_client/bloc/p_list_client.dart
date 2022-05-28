import 'package:flutter/material.dart';
import '../../../../../application/repository/r_client.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../utils/bloc_pattern/bloc_provider.dart';
import '../v_list_client.dart';
import 'b_list_client.dart';

class PListCliente extends StatelessWidget {
  const PListCliente(
      {Key? key, required this.bApplication, required this.rClient})
      : super(key: key);
  final BApplication bApplication;
  final RClient rClient;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BListClient>(
      blocBuilder: () => BListClient(bApplication, rClient),
      child: const VListCliente(),
    );
  }
}
