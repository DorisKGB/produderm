
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
        ..date = DateTime.tryParse(item['date'])
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

class EVisitToParams extends MapedorService<Visit, Map<String, dynamic>> {
  @override
  Map<String, dynamic> map(Visit item) {
    final params = <String, dynamic>{};
    params['_id'] = item.id;
    params['client_id'] = item.cliente?.id;
    params['date'] = '${item.date?.millisecondsSinceEpoch}';
    params['lat'] = item.lat;
    params['lon'] = item.lon;
    params['comment'] = item.comment;
    params['totalSale'] = item.totalSale;
    params['totalCharge'] = item.totalCharge;
    if (item.details != null) {
      params['details'] = EDetailVisitToParms().transformList(item.details!);
    }
    return params;
  }
}

class EDetailVisitToParms
    extends MapedorService<DetailsVisit, Map<String, dynamic>> {
  @override
  Map<String, dynamic> map(DetailsVisit item) {
    final params = <String, dynamic>{};
    params['_id'] = item.id;
    params['product_id'] = item.product?.id;
    params['quantity'] = item.quantity;
    params['promotion'] = item.promotion;
    //EProductToParam
    return params;
  }
}
