import 'package:produderm/core/entities/cliente.dart';

import 'details_activity.dart';

class Visit {
  String? id;
  Cliente? cliente;
  String? date;
  String? lat;
  String? lon;
  String? comment;
  double? totalSale;
  double? totalCharge;
  List<DetailsVisit>? details;
}
