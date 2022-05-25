import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../application/repository/r_product.dart';
import '../../../../../core/entities/product.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../utils/bloc_pattern/bloc_base.dart';

class BListProduct implements BlocBase {
  BListProduct(this._bApplication, this._rProduct) {
    getProducts();
  }
  final BApplication _bApplication;
  final RProduct _rProduct;
  final BehaviorSubject<List<Product>> _products =
      BehaviorSubject<List<Product>>(); // Se crea el stream
  Stream<List<Product>> get outProducts => _products.stream; // salida
  Function(List<Product>) get inProducts => _products.sink.add;

  Future<void> getProducts() async {
    try {
      List<Product> productos = await _rProduct.listProduct();
      if (!_products.isClosed) {
        inProducts(productos);
      }
    } catch (e, st) {
      _products.addError(e.toString());
    }
  }

  @override
  void dispose() {
    _products.close();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
