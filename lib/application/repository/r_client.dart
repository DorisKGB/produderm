import 'package:produderm/core/entities/cliente.dart';

import '../../core/entities/speciality.dart';

abstract class RClient {
  Future<List<Cliente>> listClient();
  Future<Cliente> createClient(Cliente cliente);
  Future<bool> updateClient(Cliente cliente);
  Future<List<Speciality>> getSpecialities();
}
