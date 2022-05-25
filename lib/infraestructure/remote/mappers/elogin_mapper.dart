import '../../../application/base/mapper.dart';
import '../../../core/entities/e_login.dart';

class ELoginFromData extends MapedorService<dynamic, ELogin> {
  @override
  ELogin map(item) {
    if (item != null) {
      return ELogin()..token = item['data'];
    }
    return ELogin();
  }
}
