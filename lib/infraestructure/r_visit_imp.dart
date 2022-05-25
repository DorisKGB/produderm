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
      Response<dynamic> response = await Dio().get(EndPoint.lisVisits.getPath(),
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
}
