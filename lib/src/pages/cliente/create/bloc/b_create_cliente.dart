import 'dart:developer';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:produderm/application/repository/r_client.dart';
import 'package:produderm/core/entities/cliente.dart';
import 'package:produderm/core/entities/speciality.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

import '../../../../../core/catalog/enum/c_cliente_type.dart';
import '../../../../../core/catalog/enum/c_pharmacy_type.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../models/m_action_view.dart';
import '../../../../utils/bloc_pattern/bloc_base.dart';
import '../../../../utils/mixin/action_view_screen.dart';
import '../../../../utils/mixin/manage_button.dart';
import '../../../../utils/validators/validator_transforms.dart';
import '../../../../utils/widgets/sw_button.dart';
import '../../list_client/bloc/b_list_client.dart';

class BCreateCliente
    with ManageButton, ValidatorTransForms, MixActionViewStream
    implements BlocBase {
  BCreateCliente(
    this._bApplication,
    this._rClient,
    this.parametros,
  ) {
    getSpecialities();
    initManageButton([
      outCodigo,
      outNombre,
      outCallePrincipal,
      outCalleSecundaria,
      outEmail,
      outTelefono,
      outClientType,
      outBirthdayDate,
      //outPharmacyType,
    ]);
    //Se llenan las variables para controlar si es actualizacion o creacion
    cliente = parametros['client'];
    _bListClient = parametros['bloc'];
    log((cliente?.specialty).toString());
    if (idIsNull()) {
      inClientType(CTypeClient.farmacia);
      inPharmacyType(CPharmacyType.cadena);
    } else {
      viewClient();
    }
  }

  final BApplication _bApplication;
  final RClient _rClient;
  final Map<String, dynamic> parametros;
  Cliente? cliente;
  BListClient? _bListClient;

  ///==================== STREAM CODIGO
  final BehaviorSubject<String> _codigo = BehaviorSubject<String>();
  Stream<String> get outCodigo =>
      _codigo.stream.transform(validateNumber(translate));
  Function(String) get inCodigo => _codigo.sink.add;

  ///==================== STREAM NOMBRE
  final BehaviorSubject<String> _nombre = BehaviorSubject<String>();
  Stream<String> get outNombre =>
      _nombre.stream.transform(validateName(translate));
  Function(String) get inNombre => _nombre.sink.add;

  ///==================== STREAM APELLIDO
  final BehaviorSubject<String> _apellido = BehaviorSubject<String>();
  Stream<String> get outApellido =>
      _apellido.stream.transform(validateString(translate));
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
      _telefono.stream.transform(validateNumber(translate));
  Function(String) get inTelefono => _telefono.sink.add;

  ///==================== STREAM REPRESENTANTE
  final BehaviorSubject<String> _representante = BehaviorSubject<String>();
  Stream<String> get outRepresentante =>
      _representante.stream.transform(validateString(translate));
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
      (initialDate.add(const Duration(days: -(365 * 120))));
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

  final BehaviorSubject<List<Speciality>> _specialities =
      BehaviorSubject<List<Speciality>>();
  Stream<List<Speciality>> get outSpecialities => _specialities.stream;
  Function(List<Speciality>) get inSpecialities => _specialities.sink.add;

  final BehaviorSubject<Speciality> _speciality = BehaviorSubject<Speciality>();
  Stream<Speciality> get outSpeciality => _speciality.stream;
  Function(Speciality) get inSpeciality => _speciality.sink.add;

  void viewClient() {
    inCodigo(cliente!.code ?? '');
    inNombre(cliente!.firstName ?? '');
    inCallePrincipal(cliente!.principalAddress ?? '');
    inCalleSecundaria(cliente!.secondaryAddress ?? '');
    inEmail(cliente!.email ?? '');
    inTelefono(cliente!.phones?.first ?? '');
    inBirthdayDate(cliente!.birthday ?? initialDate);
    inClientType(cliente!.type ?? CTypeClient.medico);
    if (cliente?.type == CTypeClient.farmacia) {
      inPharmacyType(cliente!.pharmacyType!);
    }
    if (cliente?.lastName != null && cliente?.lastName != '') {
      inApellido(cliente!.lastName!);
    }
    if (cliente?.owner != null && cliente?.owner != '') {
      inRepresentante(cliente!.owner!);
    }
    setSpeciality();
  }

  bool idIsNull() {
    if (cliente?.id == null) {
      return true;
    } else {
      return false;
    }
  }

  setSpeciality() {
    if (cliente?.specialty?.code != null) {
      if (_specialities.valueOrNull != null) {
        Speciality? speciality = _specialities.value.firstWhereOrNull(
            (element) => element.code == cliente!.specialty!.code!);
        if (speciality != null) {
          inSpeciality(speciality);
        }
      }
    }
  }

//metodo para guardar o actualizar cliente
  Future<void> guardarCliente() async {
    Cliente cliente1 = setDataForSave();
    String mensage = '';
    try {
      inButtonStatus(ButtonStatus.progress);
      if (idIsNull()) {
        Cliente res = await _rClient.createClient(cliente1);
        mensage = 'creo';
        _bListClient?.addClienteList(res);
      } else {
        await _rClient.updateClient(cliente1);
        mensage = 'actualizó';
        _bListClient?.getClients();
      }
      // Para activar el boton
      inButtonStatus(ButtonStatus.active);
      inView(MActionView.messageError('Se $mensage cliente'));
      navigator.pop();
    } catch (e, st) {
      log(e.toString(), stackTrace: st);
      inButtonStatus(ButtonStatus.active);
      inView(MActionView.messageError(e.toString()));
    }
  }

  Cliente setDataForSave() {
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
      ..specialty = _speciality.valueOrNull;
    if (!idIsNull()) {
      cliente1.id = cliente!.id;
    }
    if (_clientType.valueOrNull == CTypeClient.farmacia) {
      cliente1.pharmacyType = _pharmacyType.valueOrNull;
    }
    return cliente1;
  }

  Future<void> getSpecialities() async {
    try {
      List<Speciality> specialities =
          _bApplication.specialities ?? await _rClient.getSpecialities();
      if (specialities.isNotEmpty) {
        _bApplication.specialities = specialities;
        setSpeciality();
        inSpeciality(specialities.firstWhere((e) => e.code == "MEG",
            orElse: () => specialities.first));
      }
      inSpecialities(specialities);
    } catch (e, st) {
      log(e.toString(), stackTrace: st);
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
    _specialities.close();
    _speciality.close();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
