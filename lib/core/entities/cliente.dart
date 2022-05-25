import '../catalog/enum/c_cliente_type.dart';
import '../catalog/enum/c_pharmacy_type.dart';

class Cliente {
  String? id;
  String? code;
  String? firstName;
  String? lastName;
  String? principalAddress;
  String? secondaryAddress;
  String? lat;
  String? lon;
  CTypeClient? type;
  String? specialty;
  String? email;
  List<String?>? phones;
  String? owner;
  DateTime? birthday;
  CPharmacyType? pharmacyType;
}
