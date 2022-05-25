import 'package:flutter/material.dart';
import '../../../../../application/repository/r_product.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../utils/bloc_pattern/bloc_provider.dart';
import '../v_list_product.dart';
import 'b_list_product.dart';

class PListProduct extends StatelessWidget {
  const PListProduct(
      {Key? key, required this.bApplication, required this.rProduct})
      : super(key: key);
  final BApplication bApplication;
  final RProduct rProduct;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BListProduct>(
      blocBuilder: () => BListProduct(bApplication, rProduct),
      child: const VListProduct(),
    );
  }
}
