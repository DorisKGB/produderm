import 'package:produderm/core/entities/cliente.dart';

abstract class RClient {
  Future<List<Cliente>> listClient();
  Future<Cliente> createClient(Cliente cliente);
  Future<bool> updateClient(Cliente cliente);
}
