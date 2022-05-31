import 'dart:developer';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:produderm/application/repository/r_user.dart';
import 'package:produderm/application/repository/r_user_local.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/entities/e_login.dart';
import '../../../bloc_application/b_application.dart';
import '../../../models/m_action_view.dart';
import '../../../router/pages.dart';
import '../../../utils/bloc_pattern/bloc_base.dart';
import '../../../utils/mixin/action_view_screen.dart';
import '../../../utils/mixin/manage_button.dart';
import '../../../utils/validators/validator_transforms.dart';
import '../../../utils/widgets/sw_button.dart';

//MixActionViewStream presentar mensajes en la vista
//ValidatorTransForms validar entradas (inputs, fechas)
//ManageButton utilizar los metodos del boton
class BLogin
    with ManageButton, ValidatorTransForms, MixActionViewStream
    implements BlocBase {
  BLogin(this._bApplication, this._ruser, this._rUserLocal) {
    initManageButton([
      outUser,
      outContrasena
    ]); //Inicializa el gestor de estados para validar los inputs
  }

  final BApplication _bApplication;
  final RUser _ruser;
  final RUserLocal _rUserLocal;
  final BehaviorSubject<String> _user =
      BehaviorSubject<String>(); // Se crea el stream
  Stream<String> get outUser =>
      _user.stream.transform(validateName(translate)); // salida
  Function(String) get inUser => _user.sink.add; //entrada

  final BehaviorSubject<String> _contrasena =
      BehaviorSubject<String>(); // Se crea el stream
  Stream<String> get outContrasena => _contrasena.stream.transform(validateName(
      translate)); // salida   // se valida de acuerdo al tipo o metodo validateName
  Function(String) get inContrasena => _contrasena.sink.add; //entrada

  @override
  void dispose() {
    _user.close();
    _contrasena.close();
    closeManageButton();
  }

  Future<void> login() async {
    try {
      inButtonStatus(ButtonStatus.progress); // Para activar el boton
      ELogin elogin = await _ruser.login(ELogin()
        ..user = _user.value
        ..password = _contrasena.value);
      if (await _rUserLocal.saveToken(elogin)) {
        navigator.go(Pages.main.getPath());
      } else {
        inView(MActionView.messageError('No se inicio'));
      }
      inButtonStatus(ButtonStatus.active);
    } catch (e, st) {
      log(e.toString(),stackTrace: st);
      inView(MActionView.messageError(e.toString()));
      inButtonStatus(ButtonStatus.active);
    }
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
