import 'dart:developer';

import 'package:dio/dio.dart';
import '../application/repository/r_product.dart';
import '../application/repository/r_user_local.dart';
import '../core/entities/product.dart';
import 'remote/api/api.dart';
import 'remote/mappers/eproduct_mapper.dart';

class RProductImp implements RProduct {
  RProductImp(this.rUserLocal);
  final RUserLocal rUserLocal;
  @override
  Future<List<Product>> listProduct() async {
    try {
      final String basicAuth = 'Bearer ${(await rUserLocal.getToken()).token}';
      Response<dynamic> response = await Dio().get(EndPoint.products.getPath(),
          options:
              Options(headers: <String, String>{'authorization': basicAuth}));
      return EProductFromData().transformList(
          ((response.data as Map<String, dynamic>)['data'] ?? [])
              as List<dynamic>);
    } catch (e, st) {
      log(e.toString(),stackTrace: st);
      return Future.error('Tenemos problema al cargar productos');
    }
  }
}
