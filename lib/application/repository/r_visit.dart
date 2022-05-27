import '../../core/entities/visit.dart';

abstract class RVisit {
  Future<List<Visit>> listVisits(DateTime date);
  Future<bool> createVisit(Visit visit);
}
