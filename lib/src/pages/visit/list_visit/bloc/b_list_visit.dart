import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../application/repository/r_visit.dart';
import '../../../../../core/entities/visit.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../utils/bloc_pattern/bloc_base.dart';

class BListVisit implements BlocBase {
  BListVisit(this._bApplication, this._rVisit) {
    getVisits(date);
  }
  final BApplication _bApplication;
  final RVisit _rVisit;
  DateTime date = DateTime.now();
  //DateFormat('dd MMMM yyyy', 'es');
  DateFormat dateFormat = DateFormat.yMMMd();
  //.format(date);
  final BehaviorSubject<List<Visit>> _visits =
      BehaviorSubject<List<Visit>>(); // Se crea el stream
  Stream<List<Visit>> get outVisits => _visits.stream; // salida
  Function(List<Visit>) get inVisits => _visits.sink.add;

  Future<void> getVisits(DateTime date) async {
    try {
      List<Visit> visits = await _rVisit.listVisits(date);
      if (!_visits.isClosed) {
        inVisits(visits);
      }
    } catch (e, st) {
      log(st.toString());
      _visits.addError(e.toString());
    }
  }

  @override
  void dispose() {
    _visits.close();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
