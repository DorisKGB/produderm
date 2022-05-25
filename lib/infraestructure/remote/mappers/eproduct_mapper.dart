import 'package:produderm/core/entities/product.dart';

import '../../../application/base/mapper.dart';

class EProductFromData extends MapedorService<dynamic, Product> {
  @override
  Product map(item) {
    if (item != null) {
      return Product()
        ..id = item['_id'] as String?
        ..code = item['code'] as String?
        ..name = item['name'] as String?
        ..presentation = item['presentation'] as String?
        ..pvf = double.parse(item['pvf']?.toString() ?? "0")
        ..pvp = double.parse(item['pvp']?.toString() ?? "0")
        ..stock = item['stock'] as int?
        ..promotion = item['promotion'] as String?
        ..isProduct = item['is_product'] as bool?
        ..deleted = item['deleted'] as bool?;
    }
    return Product();
  }
}
