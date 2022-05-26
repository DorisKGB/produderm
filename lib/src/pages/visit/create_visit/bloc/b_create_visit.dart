import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:produderm/application/repository/r_product.dart';
import 'package:produderm/core/entities/product.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/entities/cliente.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../router/pages.dart';
import '../../../../utils/bloc_pattern/bloc_base.dart';
import '../../../../utils/validators/validator_transforms.dart';

class BCreateVisit with ValidatorTransForms implements BlocBase {
  BCreateVisit(this._bApplication, this.cliente, this._rProduct) {
    inDate(dateFormat.format(initialDate));
    inNombre('${cliente.firstName} ${cliente.lastName}');
    getProducts();
  }
  final BApplication _bApplication;
  final Cliente cliente;
  final RProduct _rProduct;

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

  ///==================== STREAM NUMERO PRODUCTO
  final BehaviorSubject<String> _numProduct = BehaviorSubject<String>();
  Stream<String> get outNumProduct => _numProduct.stream;
  Function(String) get inNumProduct => _numProduct.sink.add;

  ///==================== STREAM LISTA DE PRODUCTOS
  final BehaviorSubject<List<Product>> _product =
      BehaviorSubject<List<Product>>(); // Se crea el stream
  Stream<List<Product>> get outProducts => _product.stream; // salida
  Function(List<Product>) get inProducts => _product.sink.add;

  Future<void> getProducts() async {
    try {
      List<Product> product = await _rProduct.listProduct();
      if (!_product.isClosed) {
        inProducts(product);
      }
    } catch (e, st) {
      _product.addError(e.toString());
    }
  }

  void addProduct() {
    navigator.push(Pages.listProduct.getPath());
  }

  @override
  void dispose() {
    _date.close();
    _nombre.close();
    _totalCharge.close();
    _totalSales.close();
    _commentary.close();
    _product.close();
    _numProduct.close();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
