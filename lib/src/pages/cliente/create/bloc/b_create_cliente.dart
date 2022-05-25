import 'dart:developer';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:produderm/application/repository/r_client.dart';
import 'package:produderm/core/entities/cliente.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/catalog/enum/c_cliente_type.dart';
import '../../../../../core/catalog/enum/c_pharmacy_type.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../models/m_action_view.dart';
import '../../../../utils/bloc_pattern/bloc_base.dart';
import '../../../../utils/mixin/action_view_screen.dart';
import '../../../../utils/mixin/manage_button.dart';
import '../../../../utils/validators/validator_transforms.dart';
import '../../../../utils/widgets/sw_button.dart';

class BCreateCliente
    with ManageButton, ValidatorTransForms, MixActionViewStream
    implements BlocBase {
  BCreateCliente(this._bApplication, this._rClient) {
    initManageButton([
      outCodigo,
      outNombre,
      outApellido,
      outCallePrincipal,
      outCalleSecundaria,
      outEmail,
      outTelefono,
      outRepresentante,
      outBirthdayDate,
      outClientType,
      //outPharmacyType,
    ]);
    inClientType(CTypeClient.farmacia);
    inPharmacyType(CPharmacyType.cadena);
  }
  final BApplication _bApplication;
  final RClient _rClient;

  ///==================== STREAM CODIGO
  final BehaviorSubject<String> _codigo = BehaviorSubject<String>();
  Stream<String> get outCodigo =>
      _codigo.stream.transform(validateName(translate));
  Function(String) get inCodigo => _codigo.sink.add;

  ///==================== STREAM NOMBRE
  final BehaviorSubject<String> _nombre = BehaviorSubject<String>();
  Stream<String> get outNombre =>
      _nombre.stream.transform(validateName(translate));
  Function(String) get inNombre => _nombre.sink.add;

  ///==================== STREAM APELLIDO
  final BehaviorSubject<String> _apellido = BehaviorSubject<String>();
  Stream<String> get outApellido =>
      _apellido.stream.transform(validateName(translate));
  Function(String) get inApellido => _apellido.sink.add;

  ///==================== STREAM CALLE PRINCIPAL
  final BehaviorSubject<String> _callePrincipal = BehaviorSubject<String>();
  Stream<String> get outCallePrincipal =>
      _callePrincipal.stream.transform(validateName(translate));
  Function(String) get inCallePrincipal => _callePrincipal.sink.add;

  ///==================== STREAM CALLE SECUNDARIA
  final BehaviorSubject<String> _calleSecundaria = BehaviorSubject<String>();
  Stream<String> get outCalleSecundaria =>
      _calleSecundaria.stream.transform(validateName(translate));
  Function(String) get inCalleSecundaria => _calleSecundaria.sink.add;

  ///==================== STREAM EMAIL
  final BehaviorSubject<String> _email = BehaviorSubject<String>();
  Stream<String> get outEmail =>
      _email.stream.transform(validateEmail(translate));
  Function(String) get inEmail => _email.sink.add;

  ///==================== STREAM TELEFONO
  final BehaviorSubject<String> _telefono = BehaviorSubject<String>();
  Stream<String> get outTelefono =>
      _telefono.stream.transform(validateName(translate));
  Function(String) get inTelefono => _telefono.sink.add;

  ///==================== STREAM REPRESENTANTE
  final BehaviorSubject<String> _representante = BehaviorSubject<String>();
  Stream<String> get outRepresentante =>
      _representante.stream.transform(validateName(translate));
  Function(String) get inRepresentante => _representante.sink.add;

  ///==================== STREAM  y VARIABLES FECHA CUMPLE

  final BehaviorSubject<DateTime> _birthdayDate = BehaviorSubject<DateTime>();
  Stream<DateTime> get outBirthdayDate => _birthdayDate.stream;
  Function(DateTime) get inBirthdayDate => _birthdayDate.sink.add;
  //------- variables
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat.yMMMd();
  DateTime initialDate = DateTime.now();
  DateTime get firstDate =>
      (initialDate.add(const Duration(days: -(365 * 18))));
  DateTime get lastDate => initialDate;
//==================== STREAM TIPO CLIENTE
  final BehaviorSubject<CTypeClient> _clientType =
      BehaviorSubject<CTypeClient>();
  Stream<CTypeClient> get outClientType => _clientType.stream;
  Function(CTypeClient) get inClientType => _clientType.sink.add;
  CTypeClient get clientType =>
      _clientType.valueOrNull ?? CTypeClient.farmacia; //OBTIENE EL VALOR

//==================== STREAM TIPO FARMACIA
  final BehaviorSubject<CPharmacyType> _pharmacyType =
      BehaviorSubject<CPharmacyType>();
  Stream<CPharmacyType> get outPharmacyType => _pharmacyType.stream;
  Function(CPharmacyType) get inPharmacyType => _pharmacyType.sink.add;
  CPharmacyType get pharmacyType =>
      _pharmacyType.valueOrNull ?? CPharmacyType.cadena; //OBTIENE EL VALOR
//
  Future<void> guardarCliente() async {
    Cliente cliente1 = Cliente()
      ..code = _codigo.valueOrNull
      ..firstName = _nombre.valueOrNull
      ..lastName = _apellido.valueOrNull
      ..principalAddress = _callePrincipal.valueOrNull
      ..secondaryAddress = _calleSecundaria.valueOrNull
      ..email = _email.valueOrNull
      ..type = _clientType.valueOrNull
      ..phones = [_telefono.valueOrNull]
      ..owner = _representante.valueOrNull
      ..birthday = _birthdayDate.valueOrNull
      ..pharmacyType = _pharmacyType.valueOrNull;
    try {
      inButtonStatus(ButtonStatus.progress); // Para activar el boton
      await _rClient.createlient(cliente1);
      inButtonStatus(ButtonStatus.active);
      inView(MActionView.messageError('Se creo cliente'));
      navigator.pop();
    } catch (e, st) {
      inButtonStatus(ButtonStatus.active);
      inView(MActionView.messageError(e.toString()));
    }
  }

  @override
  void dispose() {
    _codigo.close();
    _nombre.close();
    _apellido.close();
    _callePrincipal.close();
    _calleSecundaria.close();
    _email.close();
    _telefono.close();
    _representante.close();
    _birthdayDate.close();
    _clientType.close();
    _pharmacyType.close();
    closeManageButton();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
