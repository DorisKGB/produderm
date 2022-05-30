import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../application/repository/r_product.dart';
import '../../../../../core/entities/product.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../utils/bloc_pattern/bloc_base.dart';
import '../../../../utils/mixin/search_mixin.dart';

class BListProduct with MixSearch implements BlocBase {
  BListProduct(this._bApplication, this._rProduct) {
    getProducts();
    initSearch(searchProduct);
  }

  List<Product>? listOld = [];
  final BApplication _bApplication;
  final RProduct _rProduct;
  final BehaviorSubject<List<Product>> _products =
      BehaviorSubject<List<Product>>(); // Se crea el stream
  Stream<List<Product>> get outProducts => _products.stream; // salida
  Function(List<Product>) get inProducts => _products.sink.add;

  void searchProduct(String queryVar) {
    List<Product> lista = listOld!.where((element) {
      if (element.name != null) {
        return element.name!.toLowerCase().contains(queryVar.toLowerCase());
      } else {
        return false;
      }
    }).toList();
    inProducts(lista);
  }

  Future<void> getProducts() async {
    try {
      List<Product> productos = await _rProduct.listProduct();
      if (!_products.isClosed) {
        inProducts(productos);
        listOld = productos;
      }
    } catch (e, st) {
      _products.addError(e.toString());
    }
  }

  @override
  void dispose() {
    _products.close();
    disposeSearch();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
