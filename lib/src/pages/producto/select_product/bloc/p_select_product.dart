import 'package:flutter/material.dart';
import '../../../../../application/repository/r_product.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../utils/bloc_pattern/bloc_provider.dart';
import '../../../visit/create_visit/bloc/b_create_visit.dart';
import '../v_select_product.dart';
import 'b_select_product.dart';

class PSelectProduct extends StatelessWidget {
  const PSelectProduct(
      {Key? key,
      required this.bApplication,
      required this.rProduct,
      required this.bCreateVisit})
      : super(key: key);
  final BApplication bApplication;
  final RProduct rProduct;
  final BCreateVisit bCreateVisit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BSelectProduct>(
      blocBuilder: () => BSelectProduct(bApplication, rProduct, bCreateVisit),
      child: const VSelectProduct(),
    );
  }
}
