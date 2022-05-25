import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:produderm/application/repository/r_product.dart';
import 'package:produderm/application/repository/r_visit.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../application/repository/r_client.dart';
import '../../../../application/repository/r_user_local.dart';
import '../../../bloc_application/b_application.dart';
import '../../../utils/bloc_pattern/bloc_base.dart';

class BMain implements BlocBase {
  BMain(this.bApplication, this.rClient, this.rProduct, this.rVisit,
      this.rUserLocal);
  final BApplication bApplication;
  final RClient rClient;
  final RProduct rProduct;
  final RVisit rVisit;
  final RUserLocal rUserLocal;
  final BehaviorSubject<int> _selectedIndex = BehaviorSubject<int>(); // tuberia
  Stream<int> get outSelectedIndex => _selectedIndex.stream; // salida
  Function(int) get inSelectedIndex => _selectedIndex.sink.add;
  int get selectedIndex => _selectedIndex.valueOrNull ?? 0;

  void onItemTapped(int index) {
    inSelectedIndex(index);
  }

  @override
  void dispose() {
    _selectedIndex.close();
  }

  @override
  GoRouter get navigator => bApplication.navigator;

  @override
  AppLocalizations get translate => bApplication.translate;
}
