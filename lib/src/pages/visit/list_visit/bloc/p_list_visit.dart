import 'package:flutter/material.dart';
import '../../../../../application/repository/r_visit.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../utils/bloc_pattern/bloc_provider.dart';
import '../v_list_visit.dart';
import 'b_list_visit.dart';

class PListVisit extends StatelessWidget {
  const PListVisit({Key? key, required this.bApplication, required this.rVisit})
      : super(key: key);
  final BApplication bApplication;
  final RVisit rVisit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BListVisit>(
      blocBuilder: () => BListVisit(bApplication, rVisit),
      child: const VListVisit(),
    );
  }
}
