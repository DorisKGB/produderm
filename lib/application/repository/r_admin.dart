import '../../core/entities/admin.dart';

abstract class RAdmin {
  Future<Admin> getAdmin();
  Future<void> closeSesion();
}
