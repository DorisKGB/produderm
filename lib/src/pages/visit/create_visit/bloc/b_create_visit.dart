import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:produderm/application/repository/r_visit.dart';
import 'package:produderm/core/entities/details_activity.dart';
import 'package:produderm/core/entities/visit.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/entities/cliente.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../models/m_action_view.dart';
import '../../../../router/pages.dart';
import '../../../../utils/bloc_pattern/bloc_base.dart';
import '../../../../utils/mixin/action_view_screen.dart';
import '../../../../utils/mixin/manage_button.dart';
import '../../../../utils/validators/validator_transforms.dart';
import '../../../../utils/widgets/sw_button.dart';

class BCreateVisit
    with ManageButton, ValidatorTransForms, MixActionViewStream
    implements BlocBase {
  BCreateVisit(this._bApplication, this.cliente, this._rVisit) {
    inDate(dateFormat.format(initialDate));
    inNombre('${cliente.firstName} ${cliente.lastName}');
    inDetailVisit([]);
    inButtonStatus(ButtonStatus.active);
  }
  final BApplication _bApplication;
  final Cliente cliente;
  final RVisit _rVisit;

  ///==================== STREAM
  DateTime initialDate = DateTime.now();
  DateFormat dateFormat = DateFormat.yMMMd();
  final BehaviorSubject<String> _date = BehaviorSubject<String>();
  Stream<String> get outDate => _date.stream;
  Function(String) get inDate => _date.sink.add;

  ///==================== STREAM NOMBRE
  final BehaviorSubject<String> _nombre = BehaviorSubject<String>();
  Stream<String> get outNombre => _nombre.stream;
  Function(String) get inNombre => _nombre.sink.add;

  ///==================== STREAM TOTAL COBRO
  final BehaviorSubject<String> _totalCharge = BehaviorSubject<String>();
  Stream<String> get outTotalCharge => _totalCharge.stream;
  Function(String) get inTotalCharge => _totalCharge.sink.add;

  ///==================== STREAM TOTAL VENTA
  final BehaviorSubject<String> _totalSales = BehaviorSubject<String>();
  Stream<String> get outTotalSales => _totalSales.stream;
  Function(String) get inTotalSales => _totalSales.sink.add;

  ///==================== STREAM COMENTARIO
  final BehaviorSubject<String> _commentary = BehaviorSubject<String>();
  Stream<String> get outCommentary =>
      _commentary.stream.transform(validateName(translate));
  Function(String) get inCommentary => _commentary.sink.add;

  ///==================== STREAM LISTA DE PRODUCTOS
  final BehaviorSubject<List<DetailsVisit>> _detailVisit =
      BehaviorSubject<List<DetailsVisit>>(); // Se crea el stream
  Stream<List<DetailsVisit>> get outDetailVisit =>
      _detailVisit.stream; // salida
  Function(List<DetailsVisit>) get inDetailVisit => _detailVisit.sink.add;
  List<DetailsVisit> get detailList => _detailVisit.valueOrNull ?? [];
  // agrega a la tuberia de lista de detalles
  Future<void> addDetailVisit(DetailsVisit detailsVisit) async {
    try {
      if (detailList.isEmpty) {
        inDetailVisit([detailsVisit]);
      } else {
        inDetailVisit((detailList..add(detailsVisit)));
      }
    } catch (e, st) {
      _detailVisit.addError(e.toString());
    }
  }

  // envia a la vista para seleccionar los productos
  void addProduct() {
    navigator.push(Pages.selectProduct.getPath(), extra: this);
  }

  void removeDetailVisit(int i) {
    detailList.removeAt(i);
    inDetailVisit(detailList);
  }

  Future<void> createVisit() async {
    try {
      Visit visita = Visit()
        ..cliente = cliente
        ..date = initialDate
        ..comment = _commentary.valueOrNull
        ..totalSale = double.tryParse(_totalSales.valueOrNull ?? '')
        ..totalCharge = double.tryParse(_totalCharge.valueOrNull ?? '')
        ..details = _detailVisit.valueOrNull;
      inButtonStatus(ButtonStatus.progress);
      await _rVisit.createVisit(visita);
      inButtonStatus(ButtonStatus.active);
      inView(MActionView.messageError('Se registró la visita'));
      navigator.pop();
    } catch (e, st) {
      inButtonStatus(ButtonStatus.active);
      inView(MActionView.messageError(e.toString()));
    }
  }

  @override
  void dispose() {
    _date.close();
    _nombre.close();
    _totalCharge.close();
    _totalSales.close();
    _commentary.close();
    _detailVisit.close();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
