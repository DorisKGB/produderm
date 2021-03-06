import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:produderm/core/entities/speciality.dart';

import '../application/repository/r_client.dart';
import '../application/repository/r_user_local.dart';
import '../core/entities/cliente.dart';
import 'remote/api/api.dart';
import 'remote/mappers/eclient_mapper.dart';
import 'remote/mappers/specility_mapper.dart';

class RClientImp implements RClient {

  RClientImp(this.rUserLocal);
  final RUserLocal rUserLocal;

  @override
  Future<List<Cliente>> listClient() async {
    try {
      final String basicAuth = 'Bearer ${(await rUserLocal.getToken()).token}';
      Response<dynamic> response = await Dio().get(EndPoint.clients.getPath(),
          options:
              Options(headers: <String, String>{'authorization': basicAuth}));
      return EClienteFromData().transformList(
          ((response.data as Map<String, dynamic>)['data'] ?? [])
              as List<dynamic>);
    } catch (e, st) {
      log(e.toString(),stackTrace: st);
      return Future.error('Tenemos problema al cargar clientes');
    }
  }

  @override
  Future<Cliente> createClient(Cliente cliente) async {
    try {
      final String basicAuth = 'Bearer ${(await rUserLocal.getToken()).token}';
      Response<dynamic> response = await Dio().post(EndPoint.clients.getPath(),
          options:
              Options(headers: <String, String>{'authorization': basicAuth}),
          data: EClienteToParams().transform(cliente));
      return Future<Cliente>.value(
          EClienteFromData().transform((response.data['data'])));
    } catch (e, st) {
      log(st.toString());
      return Future<Cliente>.error('Tenemos problema al crear cliente');
    }
  }

  @override
  Future<bool> updateClient(Cliente cliente) async {
    try {
      final String basicAuth = 'Bearer ${(await rUserLocal.getToken()).token}';
      Response<dynamic> response = await Dio().put(
          '${EndPoint.clients.getPath()}/${cliente.id}',
          options:
              Options(headers: <String, String>{'authorization': basicAuth}),
          data: EClienteToParams().transform(cliente));
      log(response.toString());
      return Future<bool>.value(true);
    } catch (e, st) {
      log(st.toString());
      return Future<bool>.error('Tenemos problema al actualizar cliente');
    }
  }

  @override
  Future<List<Speciality>> getSpecialities() async {
    try {
      final String basicAuth = 'Bearer ${(await rUserLocal.getToken()).token}';
      Response<dynamic> response = await Dio().get(
          EndPoint.specialities.getPath(),
          options: Options(headers: <String, String>{'authorization': basicAuth}),
      );
      log(response.toString());

      return SpecialityFromData().transformList(response.data['data'] as List<dynamic>);
    } catch (e, st) {
      log(st.toString());
      return Future<List<Speciality>>.error('Tenemos problema al actualizar cliente');
    }
  }
}
