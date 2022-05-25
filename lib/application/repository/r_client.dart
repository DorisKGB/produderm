import 'package:produderm/core/entities/cliente.dart';

abstract class RClient {
  Future<List<Cliente>> listClient();
  Future<bool> createlient(Cliente cliente);
}
