CPharmacyType pharmacyomCode(String? code) {
  return CPharmacyType.values.firstWhere(
      (CPharmacyType element) => element.getPharmacyType() == code,
      orElse: () => CPharmacyType.cadena);
}

enum CPharmacyType {
  cadena,
  independiente,
}

extension CPharmacyTypeDetail on CPharmacyType {
  getPharmacyType() {
    switch (this) {
      case CPharmacyType.cadena:
        return 'CAD';
      case CPharmacyType.independiente:
        return 'IND';
    }
  }

  getLabel() {
    switch (this) {
      case CPharmacyType.cadena:
        return 'Cadena';
      case CPharmacyType.independiente:
        return 'Independiente';
    }
  }
}
