import 'package:produderm/core/entities/speciality.dart';

import '../../../application/base/mapper.dart';
import '../../../core/catalog/enum/c_cliente_type.dart';
import '../../../core/catalog/enum/c_pharmacy_type.dart';
import '../../../core/entities/cliente.dart';

class EClienteFromData extends MapedorService<dynamic, Cliente> {
  @override
  Cliente map(item) {
    if (item != null) {
      return Cliente()
        ..id = item['_id'] as String?
        ..code = item['code'] as String?
        ..firstName = item['first_name'] as String?
        ..lastName = item['last_name'] as String?
        ..principalAddress = item['principal_address'] as String?
        ..secondaryAddress = item['secondary_address'] as String?
        ..lat = item['lat'] as String?
        ..lon = item['lon'] as String?
        ..type = clientcomCode(item['type'])
        ..specialty = Speciality()..code = item['specialty'] as String?
        ..email = item['email'] as String?
        ..phones = ((item['phones'] ?? []) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        ..owner = item['owner'] as String?
        ..birthday = DateTime.tryParse(item['birthday'] ?? '')
        ..pharmacyType = pharmacyomCode(item['pharmacy_type']);
    }
    return Cliente();
  }
}

//
class EClienteToParams extends MapedorService<Cliente, Map<String, dynamic>> {
  @override
  Map<String, dynamic> map(Cliente item) {
    final params = <String, dynamic>{};
    params['code'] = item.code;
    params['first_name'] = item.firstName;
    params['last_name'] = item.lastName;
    params['principal_address'] = item.principalAddress;
    params['secondary_address'] = item.secondaryAddress;
    params['lat'] = item.lat;
    params['lon'] = item.lon;
    params['type'] = item.type?.getTypeClient();
    params['email'] = item.email;
    params['phones'] = item.phones;
    params['owner'] = item.owner;
    params['specialty'] = item.specialty?.code;
    params['birthday'] =
        '${item.birthday?.year}-${item.birthday?.month}-${item.birthday?.day}';
    params['pharmacy_type'] = item.pharmacyType?.getPharmacyType();
    return params;
  }
}
