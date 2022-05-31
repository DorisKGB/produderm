import 'package:produderm/core/entities/speciality.dart';

import '../../../application/base/mapper.dart';

class SpecialityFromData extends MapedorService<dynamic, Speciality> {
  @override
  Speciality map(item) {
    if (item != null) {
      return Speciality()
        ..id = item['_id'] as String?
        ..code = item['code'] as String?
        ..name = item['name'] as String?;
    }
    return Speciality();
  }
}

