import 'dart:developer';

import 'package:dio/dio.dart';

import '../application/repository/r_user_local.dart';
import '../application/repository/r_visit.dart';
import '../core/entities/visit.dart';
import 'remote/api/api.dart';
import 'remote/mappers/evisit_mapper.dart';

class RVisitImp implements RVisit {
  RVisitImp(this.rUserLocal);
  final RUserLocal rUserLocal;
  @override
  Future<List<Visit>> listVisits(DateTime date) async {
    try {
      final String basicAuth = 'Bearer ${(await rUserLocal.getToken()).token}';
      Response<dynamic> response = await Dio().get(EndPoint.visits.getPath(),
          queryParameters: {'fecha': "${date.year}-${date.month}-${date.day}"},
          options:
              Options(headers: <String, String>{'authorization': basicAuth}));
      return EVisitFromData().transformList(
          ((response.data as Map<String, dynamic>)['data'] ?? [])
              as List<dynamic>);
    } catch (e, st) {
      log(st.toString());
      return Future.error('Tenemos problema al cargar productos');
    }
  }

  @override
  Future<bool> createVisit(Visit visit) async {
    try {
      final String basicAuth = 'Bearer ${(await rUserLocal.getToken()).token}';
      Response<dynamic> response = await Dio().post(
        EndPoint.visits.getPath(),
        options: Options(headers: <String, String>{'authorization': basicAuth}),
        data: EVisitToParams().transform(visit),
      );
      log(response.toString());
      return Future<bool>.value(true);
    } catch (e, st) {
      log(st.toString());
      return Future.error('Tenemos problema al cargar productos');
    }
  }

  @override
  Future<bool> deleteVisit(Visit visit) async {
    try {
      final String basicAuth = 'Bearer ${(await rUserLocal.getToken()).token}';
      Response<dynamic> response = await Dio().delete(
        '${EndPoint.visits.getPath()}/${visit.id}',
        options: Options(headers: <String, String>{'authorization': basicAuth}),
      );
      log(response.toString());
      return Future<bool>.value(true);
    } catch (e, st) {
      log(st.toString());
      return Future.error('Tenemos problema al cargar productos');
    }
  }
}
