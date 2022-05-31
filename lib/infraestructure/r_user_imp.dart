import 'dart:convert';
import 'dart:developer';

import 'package:produderm/application/repository/r_user.dart';

import 'package:dio/dio.dart';

import '../core/entities/e_login.dart';
import 'remote/api/api.dart';
import 'remote/mappers/elogin_mapper.dart';

class RUserImp implements RUser {
  @override
  Future<ELogin> login(ELogin user) async {
    try {
      final String basicAuth =
          'Basic ${base64Encode(utf8.encode('${user.user}:${user.password}'))}';
      Response<dynamic> response = await Dio().post(EndPoint.login.getPath(),
          options:
              Options(headers: <String, String>{'authorization': basicAuth}));
      return ELoginFromData().transform(response.data as Map<String, dynamic>);
    } catch (e, st) {
      log(e.toString(),stackTrace: st);
      return Future.error('Tenemos problema al iniciar sesión');
    }
  }
}
