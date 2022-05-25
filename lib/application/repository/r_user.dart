import '../../core/entities/e_login.dart';

abstract class RUser {
  Future<ELogin> login(ELogin user);
}
