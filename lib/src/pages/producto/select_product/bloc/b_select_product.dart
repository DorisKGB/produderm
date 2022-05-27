import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:produderm/core/entities/details_activity.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../application/repository/r_product.dart';
import '../../../../../core/entities/product.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../models/m_action_view.dart';
import '../../../../utils/bloc_pattern/bloc_base.dart';
import '../../../../utils/mixin/action_view_screen.dart';
import '../../../visit/create_visit/bloc/b_create_visit.dart';

class BSelectProduct with MixActionViewStream implements BlocBase {
  BSelectProduct(this._bApplication, this._rProduct, this.bCreateVisit) {
    getProducts();
    inNumProduct('');
  }
  final BApplication _bApplication;
  final RProduct _rProduct;
  final BCreateVisit bCreateVisit;
  final BehaviorSubject<List<Product>> _products =
      BehaviorSubject<List<Product>>(); // Se crea el stream
  Stream<List<Product>> get outProducts => _products.stream; // salida
  Function(List<Product>) get inProducts => _products.sink.add;

  ///==================== STREAM NUMERO PRODUCTO
  final BehaviorSubject<String> _numProduct = BehaviorSubject<String>();
  Stream<String> get outNumProduct => _numProduct.stream;
  Function(String) get inNumProduct => _numProduct.sink.add;
  String get numProduct => _numProduct.valueOrNull ?? '';

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

  void addDetailVisit(Product product, bool? backToCreateVisit) {
    DetailsVisit detailsVisit = DetailsVisit()
      ..product = product
      ..quantity = int.tryParse(numProduct);
    bCreateVisit.addDetailVisit(detailsVisit);
    inNumProduct('');
    inView(MActionView.messageError('Se agregó producto'));
    if (backToCreateVisit == true) {
      navigator.pop();
    }
  }

  bool validateInput() {
    if (int.tryParse(numProduct) != null) {
      return true;
    } else {
      _numProduct.addError('Ingrese número de producto');
      return false;
    }
  }

  @override
  void dispose() {
    _products.close();
    _numProduct.close();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
