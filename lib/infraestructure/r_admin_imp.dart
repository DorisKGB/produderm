import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:produderm/application/repository/r_admin.dart';
import 'package:produderm/core/entities/admin.dart';
import 'package:produderm/infraestructure/remote/mappers/eadmin_mapper.dart';

import '../application/repository/r_user_local.dart';
import 'remote/api/api.dart';

class RAdminImp implements RAdmin {
  RAdminImp(this.rUserLocal);
  final RUserLocal rUserLocal;

  @override
  Future<Admin> getAdmin() async {
    try {
      final String basicAuth = 'Bearer ${(await rUserLocal.getToken()).token}';
      Response<dynamic> response = await Dio().get(EndPoint.admin.getPath(),
          options:
              Options(headers: <String, String>{'authorization': basicAuth}));
      log(response.toString());
      return EAdminFromData()
          .transform(response.data['data'] as Map<String, dynamic>);
    } catch (e, st) {
      log(e.toString());
      return Future.error('Tenemos problema al cargar admin');
    }
  }

  @override
  Future<void> closeSesion() async {
    await rUserLocal.removeToken();
  }
}
