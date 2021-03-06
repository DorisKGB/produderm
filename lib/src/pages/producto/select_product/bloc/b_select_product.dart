import 'dart:developer';

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
import '../../../../utils/mixin/search_mixin.dart';
import '../../../visit/create_visit/bloc/b_create_visit.dart';

class BSelectProduct with MixSearch, MixActionViewStream implements BlocBase {
  BSelectProduct(this._bApplication, this._rProduct, this.bCreateVisit) {
    getProducts();
    inNumProduct('');
    initSearch(searchProduct);
  }

  List<Product>? listOld = [];
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

  Future<void> getProducts({bool refresh=false}) async {
    try {
      if(refresh){
        _bApplication.productos = null;  
      }
      List<Product> productos = _bApplication.productos ?? await _rProduct.listProduct();

      if (!_products.isClosed) {
        inProducts(productos);
        listOld = productos;
        _bApplication.productos = productos;
      }
    } catch (e, st) {
      log(e.toString(),stackTrace: st);
      _products.addError(e.toString());
    }
  }

  void addDetailVisit(Product product, bool? backToCreateVisit) {
    DetailsVisit detailsVisit = DetailsVisit()
      ..product = product
      ..quantity = int.tryParse(numProduct);
    bCreateVisit.addDetailVisit(detailsVisit);
    inNumProduct('');
    inView(MActionView.messageError('Se agreg?? producto'));
    if (backToCreateVisit == true) {
      navigator.pop();
    }
  }

  bool validateInput() {
    if (int.tryParse(numProduct) != null) {
      return true;
    } else {
      _numProduct.addError('Ingrese n??mero de producto');
      return false;
    }
  }

  @override
  void dispose() {
    _products.close();
    _numProduct.close();
    disposeSearch();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
