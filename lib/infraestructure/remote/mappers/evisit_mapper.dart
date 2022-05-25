import 'dart:ffi';

import '../../../application/base/mapper.dart';
import '../../../core/entities/details_activity.dart';
import '../../../core/entities/visit.dart';
import 'eclient_mapper.dart';
import 'eproduct_mapper.dart';

class EVisitFromData extends MapedorService<dynamic, Visit> {
  @override
  Visit map(item) {
    if (item != null) {
      return Visit()
        ..id = item['_id'] as String?
        ..cliente = EClienteFromData().transform(item['client'])
        ..date = item['date'] as String?
        ..lat = item['lat'] as String?
        ..lon = item['lon'] as String?
        ..comment = item['comment'] as String?
        ..totalSale = double.parse(item['totalSale']?.toString() ?? "0")
        ..totalCharge = double.parse(item['totalCharge']?.toString() ?? "0")
        ..details = EDetailVisitFromData().transformList(item['details']);
    }
    return Visit();
  }
}

class EDetailVisitFromData extends MapedorService<dynamic, DetailsVisit> {
  @override
  DetailsVisit map(item) {
    if (item != null) {
      return DetailsVisit()
        ..id = item['_id']
        ..product = EProductFromData().transform(item['product'])
        ..quantity = item['quantity']
        ..promotion = item['promotion'];
    }
    return DetailsVisit();
  }
}
