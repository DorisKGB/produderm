import 'package:flutter/material.dart';
import 'package:produderm/application/repository/r_product.dart';
import 'package:produderm/application/repository/r_visit.dart';

import '../../../../application/repository/r_admin.dart';
import '../../../../application/repository/r_client.dart';
import '../../../bloc_application/b_application.dart';
import '../../../utils/bloc_pattern/bloc_provider.dart';
import '../v_main.dart';
import 'b_main.dart';

class PMain extends StatelessWidget {
  const PMain({
    Key? key,
    required this.bApplication,
    required this.rClient,
    required this.rProduct,
    required this.rVisit,
    required this.rAdmin,
  }) : super(key: key);
  final BApplication bApplication;
  final RClient rClient;
  final RProduct rProduct;
  final RVisit rVisit;
  final RAdmin rAdmin;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BMain>(
      blocBuilder: () => BMain(bApplication, rClient, rProduct, rVisit, rAdmin),
      child: const VMain(),
    );
  }
}
