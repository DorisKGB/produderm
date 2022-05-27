import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../application/repository/r_admin.dart';
import '../../../../core/entities/admin.dart';
import '../../../bloc_application/b_application.dart';
import '../../../models/m_action_view.dart';
import '../../../router/pages.dart';
import '../../../utils/bloc_pattern/bloc_base.dart';
import '../../../utils/mixin/action_view_screen.dart';

class BAdmin with MixActionViewStream implements BlocBase {
  BAdmin(this._bApplication, this._rAdmin) {
    getAdmin();
  }
  final BApplication _bApplication;
  final RAdmin _rAdmin;

  final BehaviorSubject<Admin> _admin =
      BehaviorSubject<Admin>(); // Se crea el stream
  Stream<Admin> get outAdmin => _admin.stream; // salida
  Function(Admin) get inAdmin => _admin.sink.add;
  Admin get admin => _admin.valueOrNull ?? Admin();

  Future<void> getAdmin() async {
    try {
      inAdmin(await _rAdmin.getAdmin());
    } catch (e, st) {
      inView(MActionView.messageError(e.toString()));
    }
  }

  void closeSesion() {
    _rAdmin.closeSesion();
    navigator.go(Pages.signIn.getPath());
  }

  @override
  void dispose() {
    _admin.close();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
