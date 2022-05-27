import '../../../application/base/mapper.dart';
import '../../../core/entities/admin.dart';

class EAdminFromData extends MapedorService<dynamic, Admin> {
  @override
  Admin map(item) {
    if (item != null) {
      return Admin()
        ..id = item['_id'] as String?
        ..userName = item['username'] as String?
        ..name = item['name'] as String?
        ..email = item['email'] as String?
        ..role = item['role'] as String?;
    }
    return Admin();
  }
}
