import '../../core/entities/e_login.dart';

abstract class RUserLocal {
  Future<bool> saveToken(ELogin user);
  Future<ELogin> getToken();
  Future<bool> removeToken();
}
