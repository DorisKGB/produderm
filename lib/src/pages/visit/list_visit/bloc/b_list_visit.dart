import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../application/repository/r_visit.dart';
import '../../../../../core/entities/visit.dart';
import '../../../../bloc_application/b_application.dart';
import '../../../../router/pages.dart';
import '../../../../utils/bloc_pattern/bloc_base.dart';
import '../../../../utils/mixin/search_mixin.dart';

class BListVisit with MixSearch implements BlocBase {
  BListVisit(this._bApplication, this._rVisit) {
    getVisits(date);
    initSearch(searchClient);
  }

  List<Visit>? listOld = [];
  final BApplication _bApplication;
  final RVisit _rVisit;
  DateTime date = DateTime.now();
  //DateFormat('dd MMMM yyyy', 'es');
  DateFormat dateFormat = DateFormat.yMMMd();
  //.format(date);
  final BehaviorSubject<List<Visit>?> _visits =
      BehaviorSubject<List<Visit>?>(); // Se crea el stream
  Stream<List<Visit>?> get outVisits => _visits.stream; // salida
  Function(List<Visit>?) get inVisits => _visits.sink.add;
  List<Visit>? get visitList => _visits.valueOrNull ?? [];
  DateTime get firstDate => (date.add(const Duration(days: -(365 * 18))));
  void searchClient(String queryVar) {
    List<Visit> lista = listOld!.where((element) {
      if (element.cliente!.firstName != null) {
        return element.cliente!.firstName!
            .toLowerCase()
            .contains(queryVar.toLowerCase());
      } else {
        return false;
      }
    }).toList();
    inVisits(lista);
  }

  void filterByDate(DateTime dateTime) {
    inVisits(null);
    date = dateTime;
    getVisits(date);
  }

  Future<void> getVisits(DateTime date) async {
    try {
      List<Visit> visits = await _rVisit.listVisits(date);
      if (!_visits.isClosed) {
        listOld = visits;
        inVisits(visits);
      }
    } catch (e, st) {
      log(st.toString());
      _visits.addError(e.toString());
    }
  }

  void viewVisit(Visit visit) {
    navigator.push(Pages.createVisit.getPath(),
        extra: {'visit': visit, 'bloc': this});
  }

  @override
  void dispose() {
    _visits.close();
    disposeSearch();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
